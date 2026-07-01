---
name: no-silent-errors
description: Never swallow an exception without handling or re-raising it -- a bare `except` or `except Exception: pass` hides the failure instead of fixing it.
globs: "**/*.py"
---

- No bare `except:` -- name the exception type(s) you actually expect.
- No `except Exception: pass` (or equivalent) that discards the error -- log it, handle it, or let it propagate.
- If silencing a specific exception is genuinely correct, do it narrowly (catch the one type, state why) -- don't silence by accident.

## Audit Instruction

```sh
uv run ruff check --select E722,BLE001
```

Then re-read each `except` block in the diff: confirm it names a real exception type and does something with it besides `pass`.

Reference: Tim Peters, [PEP 20 -- The Zen of Python](https://peps.python.org/pep-0020/): "Errors should never pass silently. Unless explicitly silenced."
