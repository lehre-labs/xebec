---
name: own-dont-clone-to-dodge
description: Reject .clone() or Arc<Mutex<T>> used only to sidestep the borrow checker. Resolve ownership; don't paper over the question it asked.
globs: "**/*.rs"
---

- A `.clone()` or `Arc<Mutex<T>>` added only to silence a borrow error is a dodged design decision, not a fix.
- The borrow checker asked an ownership question; answer it (borrow, restructure, move) instead of papering over it.
- Clones that are genuinely needed (cheap copies, real shared ownership) are fine -- the ban is on clones whose only job is to compile.

## Audit Instruction

Re-read every `.clone()`, `Arc<Mutex<T>>`, and `Rc<RefCell<T>>` your change added. For each, state why it exists. If the only reason is "the borrow checker complained otherwise," resolve the ownership instead.

Reference: [Rust Design Patterns -- Clone to satisfy the borrow checker](https://rust-unofficial.github.io/patterns/anti_patterns/borrow_clone.html): "If a clone is used to make a borrow checker error disappear, that's a good indication this anti-pattern may be in use."
