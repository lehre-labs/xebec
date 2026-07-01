---
name: subclass-only-for-specialization
description: Reserve subclassing for true is-a specialization; use composition (wrap + delegate) for code sharing and typing.Protocol for interfaces, not inheritance.
globs: "**/*.py"
---

- Subclassing to share code between otherwise-unrelated classes (the "template method" pattern) hides where a method or attribute actually lives -- wrap the dependency in an instance attribute and delegate instead.
- Subclassing to define an interface is usually unnecessary in Python -- use `typing.Protocol` (structural typing) instead of an `abc.ABC` base class, unless nominal registration is genuinely needed.
- Reserve subclassing for real specialization: `class B(A)` only if every `A` in the codebase could be swapped for a `B` (Liskov substitution) -- not "B happens to want some of A's methods."
- Multiple inheritance and deep hierarchies compound all of the above -- needing behavior from more than one axis is the subclass-explosion signal to switch to composition.

## Audit Instruction

Re-read each `class Foo(Bar):` added in the diff: does it satisfy Liskov substitution, or does the base class exist only to be subclassed for code sharing? If subclassing is only routing calls or attributes, wrap and delegate instead -- this is a design read, not a lint.

Reference: Hynek Schlawack, [Subclassing in Python Redux](https://hynek.me/articles/python-subclassing-redux/): "Subclassing requires knowledge and discipline from you. Composition mechanically forces discipline on you."
