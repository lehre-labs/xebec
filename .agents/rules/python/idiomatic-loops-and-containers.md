---
name: idiomatic-loops-and-containers
description: Replace manual index/dict manipulation with Python's built-in iteration idioms -- enumerate, zip, dict.get, defaultdict, namedtuple, context managers.
globs: "**/*.py"
---

- Looping with `range(len(x))` or tracking a manual index -- use `enumerate()`; looping two sequences in lockstep -- use `zip()`.
- Manual dict counting/grouping (`if key not in d: d[key] = ...`) -- use `dict.get`, `collections.Counter`, or `collections.defaultdict`.
- A manual `try`/`finally` around acquiring and releasing a resource -- use a `with` statement.
- A multi-value return read by index (`result[0]`, `result[1]`) -- use a `namedtuple` or dataclass so the caller reads names, not positions.
- A function call disambiguated only by positional bools or numbers -- use keyword arguments.

## Audit Instruction

```sh
uv run ruff check --select SIM,C4
```

Then re-read the diff for what ruff won't catch: manual dict counting/grouping, index-based multi-return access, and positional flag arguments.

Reference: Raymond Hettinger, [Transforming Code into Beautiful, Idiomatic Python](https://us.pycon.org/2013/schedule/presentation/126/) (PyCon 2013) -- "When you see this, do that instead."
