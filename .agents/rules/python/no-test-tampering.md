---
name: no-test-tampering
description: Never edit an assertion to make a failing test pass. Source and its test changed in the same turn is flagged for human review.
globs: "**/*.py"
---

- A red test means the code is wrong, not the assertion. Fix the source.
- Never weaken or rewrite an assertion to go green.
- Changing a source file and its test in the same turn is a review signal -- call it out rather than burying it.

## Audit Instruction

Re-read the diff: if any test assertion was loosened or removed, confirm it tracks a real spec change, not a failing run. When source and its test changed together, flag it for human review explicitly.
