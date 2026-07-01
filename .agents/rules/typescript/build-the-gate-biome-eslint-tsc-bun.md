---
name: build-the-gate-biome-eslint-tsc-bun
description: Biome doesn't type-check, so the gate needs a second linter -- "done" requires biome + typed eslint + tsc + bun test all green.
globs: "**/*.ts"
---

- Biome's linter is fast but not type-aware; typed rules (floating promises, unsafe `any` flow) need `eslint` running the `typescript-eslint` typed configs on top of it.
- "Done" means format/lint, typed-lint, types, and tests are all green -- biome, eslint, tsc, bun test.
- No prettier -- biome is the formatter; running both fights over the same job.

## Audit Instruction

```sh
bunx biome check && bunx eslint --cache --cache-location .cache/eslint/ . && bunx tsc --noEmit && bun test
```

`--cache` skips re-linting files eslint already checked since their last change; keep `.cache/eslint/` out of git (add it to `.gitignore` once, not per repo-visit).

Reference: Effective TypeScript, "Know Which TypeScript Options You're Using" (ch2) -- enable `strict` in `tsconfig.json` so `tsc --noEmit` actually catches what this gate exists to catch.
