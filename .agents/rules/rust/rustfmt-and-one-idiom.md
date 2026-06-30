---
name: rustfmt-and-one-idiom
description: Code must be cargo fmt-clean and follow a single project idiom; no mixed error/async/style conventions across modules.
globs: "**/*.rs"
---

- Code is `cargo fmt`-clean.
- Pick one idiom per axis -- error handling, async runtime, module layout -- and match it everywhere; don't mix conventions across modules.
- Inconsistency forces every reader (human or agent) to re-learn the file's rules.

## Audit Instruction

```sh
cargo fmt --check
```

Then re-read the diff against a neighboring module: confirm error handling, async, and naming follow the same idiom already in use.
