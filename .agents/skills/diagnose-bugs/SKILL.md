---
name: diagnose-bugs
description: Diagnosis loop for hard bugs and performance regressions. Use when the user says "diagnose"/"debug this", or reports something broken/throwing/failing/slow.
argument-hint: "[what's broken]"
metadata:
  version: "2.1.0"
  authors: ["matt-pocock", "obra", "lehre-labs"]
---

# Diagnose Bugs

The one rule: **no fix without a root cause, and no root cause without a command that goes red on the bug.** Guessing is the failure this prevents.

Read `@CONTEXT.md` (if it exists) for the mental model, and check ADRs (`docs/adr/`) in the area you're touching.

## Use Cases

```md
Human: This MCP tool returns the wrong result for empty input -- debug it.
Human: cargo test is green but the CLI panics on real input. Diagnose.
Human: This async handler hangs intermittently -- find the cause.
Human: pytest passes locally but fails in CI -- figure out why.
Human: This agent loop sometimes picks the wrong tool. Diagnose it.
```

## The loop

1. **Go red.** Build one command that fails on *this* bug and run it once -- a failing test (`pytest`, `cargo test`, `bun test`), a CLI invocation diffing output, or a direct REPL/script call with the bad input. Paste the command and its red output. No red command, no fixing.
2. **Minimise.** Shrink to the smallest input that still goes red. Fewer moving parts = fewer suspects.
3. **Hypothesise.** Write 2-3 falsifiable guesses ("if X, then changing Y fixes it"), ranked, *before* touching code. Don't anchor on the first idea.
4. **Instrument.** Test one variable at a time. Reach for a debugger/REPL before logs; tag any debug logs `[DEBUG-a4f2]` so cleanup is one grep.
5. **Fix + test.** Turn the minimal repro into a regression test at a seam that hits the real bug, watch it go red, apply the fix, watch it go green.
6. **Clean up.** Remove `[DEBUG-...]` logs, re-run the loop to confirm it's gone, and note the root cause in the commit message.

## When it gets hard

Most bugs end at the steps above. Escalate to [`@FULL-DEBUG-LOOP.md`](./FULL-DEBUG-LOOP.md) only when the bug fights back -- it covers:

- **Non-deterministic / flaky** bugs -- raising the reproduction rate instead of chasing a clean repro.
- **Performance regressions** -- baseline-measure-then-bisect instead of logging.
- **Can't build a loop at all** -- what to ask for, and why you must not hypothesise without one.
- **Heavier loops** -- property/fuzz, `git bisect run`, differential and replay harnesses.
