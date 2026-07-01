---
name: deny-unsafe-escape-hatches
description: "Block unsafe, transmute, Box::leak, and forged 'static lifetimes; each needs a // SAFETY: note and human sign-off. The hatch is where the borrow checker's guarantee silently dies."
globs: "**/*.rs"
---

- No `unsafe`, `mem::transmute`, `Box::leak`, or forged `'static` lifetimes.
- These compile clean while deleting the guarantee the borrow checker was there to provide -- no test will catch it.
- If one is unavoidable, it carries a `// SAFETY:` note justifying soundness and waits for explicit human sign-off.

## Audit Instruction

```sh
cargo clippy --all-targets -- -D unsafe_code -D warnings
```

Then grep the diff for `transmute`, `Box::leak`, and `'static` forging; for each survivor confirm a `// SAFETY:` note and that a human approved it.

Reference: [`clippy::unsafe_*` and `unsafe_code`](https://github.com/rust-lang/rust-clippy) lint index. Also David Drysdale, [Effective Rust, Item 16 -- Avoid writing unsafe code](https://effective-rust.com/unsafe.html): hunt the standard library and crates.io for existing encapsulated `unsafe` before writing your own, and wrap what remains behind a documented, minimal-blast-radius layer.
