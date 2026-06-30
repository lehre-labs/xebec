---
name: test-logic-not-just-compile
description: "\"It compiles\" != \"it's correct.\" Require tests for behavior the type system can't see -- the business-logic residue is yours, not the compiler's."
globs: "**/*.rs"
---

- A clean compile proves types line up, not that logic is right.
- Cover the behavior the compiler can't see -- business rules, edge cases, off-by-ones -- with tests.
- This is the Goal-Driven Execution principle (AGENTS.md) applied to Rust: turn the task into a test, then make it pass.

## Audit Instruction

```sh
cargo test
```

Confirm the new behavior has a test that would fail if the logic were wrong -- not just that the code builds.
