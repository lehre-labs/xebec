---
name: test-is-the-only-oracle
description: Runtime-semantic bugs (mutating a list mid-iteration, off-by-one, None that's really there) are caught only by tests. Require them for any logic path.
globs: "**/*.py"
---

- Type checks and lint never see runtime semantics -- list mutation during iteration, off-by-ones, a `None` that really arrives.
- The only oracle for behavior is a test; any logic path needs one.
- This is the Goal-Driven Execution principle (AGENTS.md) applied to Python: write the test that pins the behavior, then make it pass.

## Audit Instruction

```sh
uv run pytest
```

Confirm each logic path added has a test that would fail if the behavior were wrong.
