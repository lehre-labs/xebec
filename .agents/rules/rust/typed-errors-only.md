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

Reference: [Rust API Guidelines -- error types](https://rust-lang.github.io/api-guidelines/interoperability.html). Also David Tolnay (author, thiserror/anyhow), [anyhow README](https://crates.io/crates/anyhow): "Use Anyhow if you don't care what error type your functions return... Use thiserror if you are a library that wants to design your own dedicated error type(s)." And matklad, [Study of std::io::Error](https://matklad.github.io/2020/10/15/study-of-std-io-error.html), on the encapsulate-vs-expose tension behind that split.
