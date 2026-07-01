---
name: no-explicit-any-prefer-unknown
description: No `any` in new code -- values of unknown shape are typed `unknown` and narrowed before use, not typed away with `any`.
globs: "**/*.ts"
---

- No `any` in parameters, returns, or variables in new code.
- A value whose shape genuinely isn't known yet is `unknown`, narrowed (`typeof`, a type guard, a schema parse) before it's used.
- `any` doesn't just skip checking that value -- it silently turns off checking everywhere that value flows.

## Audit Instruction

```sh
bunx eslint --cache --cache-location .cache/eslint/ --rule '{"@typescript-eslint/no-explicit-any":"error","@typescript-eslint/no-unsafe-assignment":"error","@typescript-eslint/no-unsafe-call":"error","@typescript-eslint/no-unsafe-member-access":"error","@typescript-eslint/no-unsafe-return":"error"}' .
```

Reference: Dan Vanderkam, *Effective TypeScript*, "Limit Use of the any Type" (ch1) and "Use unknown Instead of any for Values with an Unknown Type" (ch5): `any` disables the type checker for everything it touches, not just the one value it's applied to.
