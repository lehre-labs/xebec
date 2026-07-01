---
name: readonly-by-default
description: Function parameters and object properties are `readonly` unless the function's whole job is to mutate them.
globs: "**/*.ts"
---

- Function parameters are typed `readonly` (or `Readonly<T>`/`readonly T[]`) unless mutating the input is the function's actual purpose.
- Object and class properties are `readonly` unless reassigned outside the constructor.
- `readonly` turns "this function doesn't touch your data" from a comment into something the compiler checks.

## Audit Instruction

```sh
bunx eslint --cache --cache-location .cache/eslint/ --rule '{"@typescript-eslint/prefer-readonly":"error","@typescript-eslint/prefer-readonly-parameter-types":"error"}' .
```

Reference: Dan Vanderkam, *Effective TypeScript*, "Use readonly to Avoid Errors Associated with Mutation" (ch2).
