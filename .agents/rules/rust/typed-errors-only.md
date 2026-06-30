---
name: typed-errors-only
description: Model fallible ops with Result + thiserror/anyhow at boundaries. No panicking control flow, no stringly-typed errors.
globs: "**/*.rs"
---

- Fallible operations return `Result`; errors are typed (`thiserror` for libraries, `anyhow` at application boundaries).
- No control flow via `panic!`/`unwrap`, and no `Err(String)` stringly-typed errors.
- The error type is part of the API contract -- design it, don't stringify it.

## Audit Instruction

Re-read the diff for `panic!`, `Err(format!(...))`, and `Box<dyn Error>` used as the primary error type. Replace panicking control flow with `Result`, and stringly-typed errors with a typed enum.

Reference: [Rust API Guidelines -- error types](https://rust-lang.github.io/api-guidelines/interoperability.html).
