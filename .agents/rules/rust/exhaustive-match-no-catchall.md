---
name: exhaustive-match-no-catchall
description: Require exhaustive match; ban _ => wildcards that silently swallow enum variants added later. Let the compiler force every case.
globs: "**/*.rs"
---

- Match every enum variant by name; no `_ =>` catch-all over an owned enum.
- A wildcard makes a variant added later compile silently instead of forcing you to handle it.
- Genuine open-ended matches (over integers, strings) may use `_`; the ban targets enums you control.

## Audit Instruction

```sh
cargo clippy --all-targets -- -W clippy::wildcard_enum_match_arm
```

Then re-read each `match` over a local enum in the diff and confirm no arm collapses real variants into `_`.
