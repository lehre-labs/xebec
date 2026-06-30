---
name: no-accidental-quadratic
description: "Watch algorithmic cost in hot paths: no list membership in loops, no += string building, no materializing what a generator would stream."
globs: "**/*.py"
---

- No `x in seq` against a `list`/`tuple` inside a loop -- use a `set`/`dict` for O(1) lookups.
- Build strings with a list + `"".join(...)`, never `+=` in a loop.
- Stream with a generator where the whole list isn't needed; don't materialize just to discard most of it.
- Hoist loop-invariant work out of the loop; don't recompute per iteration.

## Audit Instruction

```sh
uv run ruff check --select PERF,C4
```

Then re-read each loop in the diff for list-membership lookups, `+=` string building, and needless materialization -- fix the algorithmic cost, not just whatever the linter flagged.

Reference: [Ruff Perflint (PERF) and flake8-comprehensions (C4) rules](https://docs.astral.sh/ruff/rules/#perflint-perf).
