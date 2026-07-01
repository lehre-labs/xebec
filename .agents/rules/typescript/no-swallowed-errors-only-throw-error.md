---
name: no-swallowed-errors-only-throw-error
description: No empty or swallowing `catch` block, and only `Error` (or a subclass) is ever thrown -- never a raw string or plain object.
globs: "**/*.ts"
---

- No `catch` block that discards the error without logging, handling, or rethrowing it.
- Only throw `Error` instances (or a subclass) -- never `throw "message"` or `throw { code }`. A thrown non-`Error` loses its stack trace and forces every catcher to guess its shape.
- If silencing a specific failure is genuinely correct, do it narrowly and say why -- don't silence by accident.

## Audit Instruction

```sh
bunx eslint --cache --cache-location .cache/eslint/ --rule '{"@typescript-eslint/only-throw-error":"error"}' .
```

Then re-read each `catch` block in the diff: confirm it does something with the error besides discarding it.

Reference: [typescript-eslint rule docs](https://typescript-eslint.io/rules/) -- `only-throw-error`.
