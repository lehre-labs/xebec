---
name: test-logic-not-just-types
description: A clean `tsc` proves types line up, not that logic is right -- every logic path needs a `bun test` case, and tests read top-to-bottom without hunting through nested `beforeEach` state.
globs: "**/*.ts"
---

- `tsc --noEmit` passing proves the types are consistent, not that the behavior is correct -- business rules, edge cases, and off-by-ones still need a test.
- Avoid nested `describe`/`beforeEach` chains that build up shared mutable state; prefer inline `test`/`it` bodies or a plain setup function a reader can trace without scrolling.
- Tracing what a test depends on through several nested `beforeEach` blocks is the actual cost -- not nesting for its own sake.

## Audit Instruction

```sh
bun test
```

Confirm the new behavior has a test that would fail if the logic were wrong -- not just that `tsc`/`biome` are clean. Then re-read any test the diff added: if it depends on state assigned in a nested `beforeEach`, prefer inlining the setup in the test body or extracting a plain function.

Reference: Kent C. Dodds, ["Avoid Nesting when you're Testing"](https://kentcdodds.com/blog/avoid-nesting-when-youre-testing): "reducing the amount of variable mutation has resulted in vastly simpler test maintenance." Also Dan Vanderkam, *Effective TypeScript*, "Understand the Relationship Between Type Checking and Unit Testing" (ch9).
