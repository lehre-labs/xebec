---
name: no-unwrap-expect-in-prod
description: "Forbid .unwrap()/.expect() outside #[cfg(test)]; propagate with ?. In a library every unwrap is a panic the caller cannot recover from."
globs: "**/*.rs"
---

- No `.unwrap()` or `.expect()` outside `#[cfg(test)]`.
- Propagate with `?`; the choice between `?` and `.unwrap()` is a design decision the agent cannot make for the caller.
- Tests may unwrap freely -- the ban is about production paths.

## Audit Instruction

```sh
cargo clippy --all-targets -- -D clippy::unwrap_used -D clippy::expect_used
```

Reference: [`clippy::unwrap_used`, `clippy::expect_used`](https://github.com/rust-lang/rust-clippy) lint index. Also David Drysdale, [Effective Rust, Item 18 -- Don't panic](https://effective-rust.com/panic.html): prefer returning `Result` to `panic!`/`.unwrap()`/`.expect()`, with the one carve-out that it's fine "if you have control of `main`."
