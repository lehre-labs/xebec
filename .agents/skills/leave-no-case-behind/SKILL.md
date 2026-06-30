---
name: leave-no-case-behind
description: Enumerate the full case space for a feature or flow -- interface states, paths, boundaries, assumptions, cross-role risks -- then derive concrete, traceable test cases to feed /tdd. Run before coding to catch design gaps, or after a build as a coverage check.
argument-hint: "[feature or flow]"
disable-model-invocation: true
metadata:
  version: "1.0.0"
  authors: ["lehre-labs"]
---

# Leave No Case Behind

Enumerate every case a feature can be in before writing code. Catch gaps in design, not in production. Then, if tests will follow, turn those cases into concrete tests to hand to `/tdd`.

## Use Cases

```md
Human: Before I touch the cache-eviction logic, map every case it can land in.
Human: Sweep the case space for the `xebec sync` command, then derive the tests.
Human: We shipped the rate limiter -- enumerate the edges and check our coverage before review.
```

## Context Awareness

Read `@CONTEXT.md` so the cases and test names use the project's ubiquitous language, and `@AGENTS.md` so the analysis stays within stated principles. A term you need but cannot find is itself an unresolved case -- surface it.

## Process

### Step 1: Identify the Subject

Determine what is being analyzed. Accept one of:

- A feature or flow description from the user
- A PRD #, plan path, or issue (read it)
- A code file or component path (read it)
- The current conversation context

If ambiguous, ask: "What feature or flow should I analyze?"

### Step 2: Interface State Audit (the 5 states)

For every surface in the feature -- a CLI command, an MCP tool, an agent-facing output -- enumerate all five states:

| State | Question | Output |
| --- | --- | --- |
| Success | What does this return with valid input and complete data? | Concrete description of the populated result |
| Empty | What if there is zero data (no results, fresh state, nothing matched)? | What the caller sees + guidance or next step |
| In-progress | What happens during a long or async operation? | Progress signal, streaming, partial flush behavior |
| Partial | What if data is sparse or only some of it resolved? | Behavior when the result is incomplete but not failed |
| Error | What if the operation fails (bad input, missing permission, dependency down)? | Error message, exit code, and recovery action |

Skip this step only for pure-internal logic with no observable surface.

### Step 3: Path Analysis

Enumerate all paths through the feature.

**Happy path (exactly one):** entry point -> action sequence -> success outcome. The default scenario with valid input and no exceptions.

**Sad paths (expected failures):**

- Validation errors (invalid input, missing required argument)
- Permission/auth failures (missing credential, insufficient scope)
- Business-rule violations (quota exceeded, duplicate, conflicting state)
- Infrastructure failures (timeout, non-zero exit, process killed)
- Dependency failures (upstream API down, file or socket unreachable)

For each sad path: what does the consumer see, and how do they recover?

**Edge cases (unlikely but impactful):**

- Boundary values (0 items, 1 item, max, max+1)
- Special input (unicode, extremely long strings, untrusted args, injection into a shelled-out command)
- Timing (double-invocation, rapid resubmission, concurrent runs, stale state)
- Interruption (cancelled mid-operation, retried, resumed, killed and restarted)

### Step 4: Assumption Busting

List every implicit assumption, then challenge it:

- **Assumption:** the config file exists and is well-formed. **Challenge:** what if it is missing, empty, or malformed?
- **Assumption:** the operation completes in a few seconds. **Challenge:** what if it takes 30 seconds, or never returns?
- **Assumption:** the caller has permission to run this. **Challenge:** what if the credential is absent or read-only?

### Step 5: Cross-Role Sweep

Three quick passes from different perspectives:

- **Engineer:** race conditions? data integrity? idempotency? what if the operation is retried?
- **Consumer (the human or calling agent):** is the output legible? is the error recoverable? are exit codes, flags, and messages unambiguous?
- **Adversary:** malformed or hostile args? injection? untrusted input reaching a shell or eval? resource exhaustion?

### Step 6: Test Design (optional)

If tests will follow, turn the enumerated cases into concrete, traceable test cases using systematic techniques, then hand the table to `/tdd`. Skip when no tests are planned (pure analysis). Preserve the originating case ID (`CASE-*`) in each generated test row.

```
leave-no-case-behind
  -> behavioral states and paths
  -> systematic test techniques
  -> concrete, traceable test cases
  -> /tdd
```

First list the **inputs** (every param, field, action, config value), **outputs** (return values, state changes, side effects), and **state** (flags, prior actions, environment) that affect behavior.

**Equivalence partitioning** -- divide each input's domain into classes where all values behave the same; pick one representative per class.

```
Input: search --limit
  Valid:   [1-50]
  Invalid: [0], [negative], [51+], [non-numeric]
```

**Boundary value analysis** -- for each ranged input, test at and around the edges.

```
--limit 1-50:      0, 1, 2, 49, 50, 51
--timeout 0-3600s: -1, 0, 1, 3599, 3600, 3601
```

**Decision table** -- for two or more interacting conditions, enumerate combinations and the expected action. Skip if fewer than two interacting conditions.

| id | cache hit | --no-cache | expected |
| --- | --- | --- | --- |
| 1 | T | F | serve from cache |
| 2 | T | T | bypass, re-fetch |
| 3 | F | F | fetch + populate |
| 4 | F | T | fetch, skip write |

**State transition** -- model states and transitions; test every valid transition, the invalid ones, and a full path. Skip if there is no meaningful state machine.

```
States: [Queued] -> [Running] -> [Succeeded]
                         \-> [Failed] -> [Queued]
Valid:   Queued + start    = Running
Invalid: Succeeded + retry = error
Path:    Queued -> Running -> Failed -> Queued -> Running -> Succeeded
```

**Compile and prioritize** -- merge, dedupe, then rank:

- **Must:** happy path, all boundary values, all invalid equivalence classes.
- **Should:** all decision-table combinations, all state transitions.
- **Nice:** combinatorial edges, stress/volume, concurrency.

Don't design tests for generated code (openapi-ts, alembic migrations), pure config, or third-party internals.

## Output Format

Write the case map using the template [`@CASE-ANALYSIS.template.md`](./CASE-ANALYSIS.template.md). If the subject is a PRD, plan, or issue, append it there as a `## Case Analysis` section -- demote the template's headings one level -- so the analysis travels with the work. Otherwise emit it standalone (a file or inline).

## When NOT to Use

- Pure refactors with no behavior change
- Dependency bumps
- Config/env changes
- Features whose cases are already documented
