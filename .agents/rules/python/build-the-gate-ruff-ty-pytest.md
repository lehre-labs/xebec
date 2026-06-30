---
name: build-the-gate-ruff-ty-pytest
description: Python ships no compiler gate, so build it -- "done" requires ruff + ty + pytest green. The verifier is DIY because the language withholds it.
globs: "**/*.py"
---

- Python has no compiler to catch mechanical errors, so the gate is something you assemble and run, not skip.
- "Done" means lint, types, and tests are all green -- ruff, ty, pytest.
- Each tool covers a different failure class; none substitutes for another.

## Audit Instruction

```sh
uv run ruff check && uv run ty check && uv run pytest
```
