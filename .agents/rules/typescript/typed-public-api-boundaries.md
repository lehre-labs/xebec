---
name: typed-public-api-boundaries
description: Every exported function has explicit parameter and return types; every type that appears in a public signature is itself exported.
globs: "**/*.ts"
---

- Every exported function or class method has explicit parameter types and an explicit return type -- don't lean on inference at the public boundary.
- Any type that appears in an exported signature is itself exported; a caller should never hit a type they can't name.
- Inference is fine internally; at the boundary, the signature is the contract and should be written down, not inferred.

## Audit Instruction

```sh
bunx eslint --cache --cache-location .cache/eslint/ --rule '{"@typescript-eslint/explicit-module-boundary-types":"error","@typescript-eslint/explicit-function-return-type":"error"}' .
```

Reference: Dan Vanderkam, *Effective TypeScript*, "Apply Types to Entire Function Expressions When Possible" (ch2) and "Export All Types That Appear in Public APIs" (ch8).
