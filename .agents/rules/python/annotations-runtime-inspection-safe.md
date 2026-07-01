---
name: annotations-runtime-inspection-safe
description: On Python 3.14+, annotations are deferred (PEP 649) not stringified -- don't quote forward-refs defensively, but confirm any TYPE_CHECKING-only name a framework inspects at runtime is safe first.
globs: "**/*.py"
---

- Don't quote forward-refs or add `from __future__ import annotations` defensively -- 3.14's deferred evaluation (PEP 649) makes both dead weight; let ruff's `UP037` catch stragglers.
- Before removing existing quotes/`TYPE_CHECKING` guards, confirm every framework that inspects your annotations (FastAPI, Pydantic, SQLAlchemy, attrs, dataclasses) is pinned to a version supporting `annotationlib.Format.FORWARDREF` -- an older pin raises `NameError` at first request, not at import.
- Bump the annotation-inspecting framework before removing the quotes, not after -- doing it in the other order breaks every affected call site at once, in CI or in production.

## Audit Instruction

```sh
uv run ruff check --select UP037 --target-version py314
```

Then grep the diff for `if TYPE_CHECKING:` blocks and cross-check each name referenced there against a runtime-inspected annotation (a FastAPI endpoint, a Pydantic model, an ORM-mapped class).

Reference: [PEP 649 -- Deferred Evaluation of Annotations](https://peps.python.org/pep-0649/); [What's New in Python 3.14](https://docs.python.org/3/whatsnew/3.14.html); Mergify, [What PEP 649 Actually Breaks](https://mergify.com/blog/python-314-what-pep-649-actually-breaks).
