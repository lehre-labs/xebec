---
name: valid-states-unrepresentable
description: Design types so an invalid state can't be constructed -- no sentinel values (`-1`, `""`) standing in for "missing," no flag combinations that imply nonsense.
globs: "**/*.ts"
---

- Don't use `-1`, `""`, or another in-range value as a sentinel for "missing" or "not loaded yet" -- give the special case its own type (e.g. `null`, a tagged variant) so TypeScript can enforce that callers handle it.
- Don't model state with independent optional/boolean fields whose combinations can express a state that shouldn't exist (e.g. `isLoading: true` and `data: T` both set) -- a discriminated union should make the invalid combination unrepresentable.
- A type that can only ever describe valid states removes a whole class of runtime checks, because the compiler already ruled the bad ones out.

## Audit Instruction

Re-read each type/interface the diff added or touched: for any sentinel literal or independent flag fields, confirm the invalid combination is actually impossible to construct, not just conventionally avoided.

Reference: Dan Vanderkam, *Effective TypeScript*, "Prefer Types That Always Represent Valid States" and "Use a Distinct Type for Special Values" (ch4).
