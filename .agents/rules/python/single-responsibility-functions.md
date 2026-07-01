---
name: single-responsibility-functions
description: Keep functions short and one-job; split anything that needs "and" in its name. Agents can't trace a 100-line god function and edit it blind.
globs: "**/*.py"
---

- One job per function; if its honest name needs "and", split it.
- Keep functions short enough to hold in one read -- a god function can't be edited safely from a partial window.
- High branching or length is the smell; extract before it grows.

## Audit Instruction

```sh
uv run ruff check --select C901,PLR0915
```

Then re-read any function the diff grew past one screen and confirm it does one thing.

Reference: Tim Peters, [PEP 20 -- The Zen of Python](https://peps.python.org/pep-0020/): "Simple is better than complex; complex is better than complicated."
