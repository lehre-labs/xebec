---
name: ruff-clean-and-consistent
description: Pass ruff check + ruff format; pick one async pattern and one error style and use it everywhere. Inconsistency forces the agent to re-puzzle each file.
globs: "**/*.py"
---

- Code passes `ruff check` and `ruff format`.
- Pick one async pattern and one error-handling style and apply them across the codebase.
- Mixed conventions make every file a fresh puzzle for the next reader.

## Audit Instruction

```sh
uv run ruff check && uv run ruff format --check
```

Then re-read the diff against a neighboring module and confirm async and error handling match the existing style.
