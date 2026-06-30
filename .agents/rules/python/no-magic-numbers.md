---
name: no-magic-numbers
description: Replace bare literals with named constants (SECONDS_IN_A_DAY = 86400). An unnamed number is something the agent guesses -- and guesses wrong.
globs: "**/*.py"
---

- No bare numeric literals in logic; bind them to named constants (`SECONDS_IN_A_DAY = 86400`).
- A name states intent the digit hides; an unnamed number is a guess waiting to be made wrong.
- Loop bounds 0/1 and other self-evident cases are fine -- the ban targets meaningful literals.

## Audit Instruction

```sh
uv run ruff check --select PLR2004
```

Reference: [Ruff rule PLR2004 -- magic-value-comparison](https://docs.astral.sh/ruff/rules/magic-value-comparison/).
