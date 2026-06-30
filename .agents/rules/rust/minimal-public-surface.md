---
name: minimal-public-surface
description: Keep pub minimal and document every public item. Agents over-export and leak internals the API never meant to expose.
globs: "**/*.rs"
---

- Default to private; make an item `pub` only when something outside the module needs it.
- Every public item carries a doc comment stating its contract.
- Over-exporting leaks internals and freezes them into the API by accident.

## Audit Instruction

```sh
cargo clippy --all-targets -- -D missing_docs
```

Then re-read each `pub` added in the diff and confirm an external caller actually needs it; otherwise narrow the visibility (`pub(crate)`, private).
