# Case Analysis: {agent-write: the feature or flow under analysis}

## Interface States

{agent-write: One row per surface -- a CLI command, an MCP tool, an agent-facing output. Fill every state; write "n/a" only where a surface genuinely cannot reach one.}

| Surface | Success | Empty | In-progress | Partial | Error |
| --- | --- | --- | --- | --- | --- |

## Paths

**Happy path:** {agent-write: entry -> step -> step -> success outcome}

**Sad paths:**

{agent-write: One bullet per expected failure -- what the consumer sees, then how they recover.}

<sad-path-example>
- `search --limit 0`: rejected with a usage error -> caller re-runs with a value in [1-50]
- upstream API times out: partial result flushed with a non-zero exit -> caller retries with backoff
</sad-path-example>

**Edge cases:**

{agent-write: One bullet per boundary, timing, or untrusted-input case -- impact, then mitigation.}

## Assumptions Challenged

{agent-write: One bullet per implicit assumption -> what breaks if it is violated.}

## Cross-Role Flags

{agent-write: Concerns from each lens. Drop a lens only if it surfaced nothing.}

- [ENG] {agent-write: race conditions, idempotency, data integrity, retries}
- [CONSUMER] {agent-write: output legibility, recoverable errors, unambiguous exit codes and flags}
- [ADVERSARY] {agent-write: malformed or hostile args, injection, untrusted input reaching a shell, resource exhaustion}

## Test Cases (if tests follow)

**Inputs / outputs / state:** {agent-write: the inputs, outputs, and state that drive behavior}

{agent-write: One row per concrete test. Keep the originating CASE-* id in `source` so every test traces back to a case.}

| id | source | technique | input | value | expected |
| --- | --- | --- | --- | --- | --- |

<test-cases-example>
| EP-1 | CASE-EC-1 | equivalence | --limit valid | 25 | accepted |
| BV-2 | CASE-EC-1 | boundary | --limit below min | 0 | validation error |
| DT-2 | CASE-SP-1 | decision | hit=T / --no-cache=T | bypass | re-fetch |
| ST-1 | CASE-ST-1 | state | Queued + start | Running | yes |
</test-cases-example>

**Priority:** Must {agent-write: ids} / Should {agent-write: ids} / Nice {agent-write: ids}
