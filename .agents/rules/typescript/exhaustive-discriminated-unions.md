---
name: exhaustive-discriminated-unions
description: Model variants as a tagged union of interfaces, not one interface with optional fields; every switch over the tag must be exhaustive.
globs: "**/*.ts"
---

- Represent a value that can be one of several shapes as a union of interfaces sharing a discriminant field, not a single interface with a grab-bag of optional properties.
- Every `switch`/`if` chain over the discriminant is exhaustive: an unhandled variant is a compile error, not a silent fallthrough.
- A wildcard `default` that swallows the remaining cases makes a variant added later compile silently instead of forcing you to handle it -- same failure mode as a Rust `_ =>` catch-all.

## Audit Instruction

```sh
bunx eslint --cache --cache-location .cache/eslint/ --rule '{"@typescript-eslint/switch-exhaustiveness-check":"error"}' .
```

Then re-read each `switch` over a local union in the diff: confirm no arm collapses real variants into a `default`, and that an unhandled case is caught by assigning it to a `never`-typed variable.

Reference: Dan Vanderkam, *Effective TypeScript*, "Prefer Unions of Interfaces to Interfaces with Unions" (ch4) and "Use never Types to Perform Exhaustiveness Checking" (ch7).
