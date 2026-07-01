---
name: handle-promises-no-floating
description: Every Promise is awaited, returned, or explicitly voided -- no fire-and-forget async calls, no raw callback APIs where async/await would flow types through.
globs: "**/*.ts"
---

- Every Promise-returning call is `await`ed, `return`ed, or explicitly marked as intentionally unhandled (`void somePromise()`) -- never left to float.
- Prefer `async`/`await` over raw callback-based APIs; callbacks break the type flow that `async` functions preserve end to end.
- An unhandled rejection from a floating Promise fails silently at runtime -- exactly the kind of error a type checker can't see but a lint rule can.

## Audit Instruction

```sh
bunx eslint --cache --cache-location .cache/eslint/ --rule '{"@typescript-eslint/no-floating-promises":"error","@typescript-eslint/no-misused-promises":"error"}' .
```

Reference: Dan Vanderkam, *Effective TypeScript*, "Use async Functions Instead of Callbacks to Improve Type Flow" (ch3).
