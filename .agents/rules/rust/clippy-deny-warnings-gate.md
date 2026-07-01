---
name: clippy-deny-warnings-gate
description: "\"Done\" means cargo clippy --all-targets -- -D warnings is clean. Lint is the verifier the agent must satisfy, not a suggestion it can leave dirty."
globs: "**/*.rs"
---

- A change is not "done" until clippy is clean with warnings denied.
- Lint is the gate, not advice -- do not leave warnings for later.
- The post-edit `rs-post-clippy` hook surfaces issues per file; this rule is the standard the whole change must meet before done.

## Audit Instruction

```sh
cargo clippy --all-targets -- -D warnings
```

Reference: David Drysdale, [Effective Rust, Item 29 -- Listen to Clippy](https://effective-rust.com/clippy.html): "you should make your code Clippy-warning free... Clippy should also be enabled in your CI system."
