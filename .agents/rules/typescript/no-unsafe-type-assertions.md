---
name: no-unsafe-type-assertions
description: No `as X` or `!` to force a type past the checker -- if one is unavoidable, hide it inside one well-typed function at the boundary.
globs: "**/*.ts"
---

- No `as X` type assertion or `!` non-null assertion used to silence the checker instead of narrowing the value.
- If an assertion is genuinely unavoidable (a library boundary the checker can't see through), it lives inside one small, well-typed function -- the rest of the codebase calls that function and never sees the assertion.
- An assertion is a promise to the compiler that you're right; every caller of the surrounding code inherits the risk if you're not.

## Audit Instruction

```sh
bunx eslint --cache --cache-location .cache/eslint/ --rule '{"@typescript-eslint/consistent-type-assertions":"error","@typescript-eslint/no-non-null-assertion":"error","@typescript-eslint/no-unsafe-type-assertion":"error"}' .
```

Then re-read each `as`/`!` the diff added: confirm it's isolated inside one narrowly-typed function rather than scattered at call sites.

Reference: Dan Vanderkam, *Effective TypeScript*, "Hide Unsafe Type Assertions in Well-Typed Functions" (ch5).
