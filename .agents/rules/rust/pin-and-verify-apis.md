---
name: pin-and-verify-apis
description: Lock crate versions; verify any method's existence and semantics against that version's docs.rs before use. Guards version drift and interpolated-API hallucination.
globs: "**/*.rs"
---

- Pin crate versions in `Cargo.toml`; don't float majors.
- Before calling a method you didn't write, verify it exists with the expected signature and semantics in *that pinned version's* docs.rs page.
- An API that "looks right" can be hallucinated or shifted across versions -- the compiler accepts the wrong-semantics call that the runtime then breaks on.

## Audit Instruction

For each external-crate method introduced in the diff, open `https://docs.rs/<crate>/<pinned-version>` and confirm the signature and behavior match the call. Run:

```sh
cargo build && cargo test
```
