---
name: type-hint-and-check
description: Annotate all public functions and run ty (or mypy) as a gate. Dynamic typing hides the wrong-arg / wrong-shape mistakes Rust would reject at compile time.
globs: "**/*.py"
---

- Every public function has typed parameters and return.
- Run a type checker as a gate, not a suggestion -- it is the closest Python has to a compile step.
- Untyped code lets wrong-arg and wrong-shape bugs survive to runtime.

## Audit Instruction

```sh
uv run ty check
```

Reference: [PEP 484 -- Type Hints](https://peps.python.org/pep-0484/). Also Tim Peters, [PEP 20](https://peps.python.org/pep-0020/): "Explicit is better than implicit."
