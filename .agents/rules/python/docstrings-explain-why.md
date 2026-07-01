---
name: docstrings-explain-why
description: Document intent and edge cases, not the obvious "what." The why is exactly the context an agent can't infer from a partial window.
globs: "**/*.py"
---

- Docstrings state intent, invariants, and edge cases -- the context a partial window hides.
- Don't restate the signature or narrate the obvious "what"; the code already says that.
- If there's nothing non-obvious to say, leave it out rather than pad.

## Audit Instruction

Re-read each docstring in the diff: delete any that merely restate the function name or signature, and add the *why* (intent, edge cases, gotchas) wherever it's missing.

Reference: [PEP 257 -- Docstring Conventions](https://peps.python.org/pep-0257/). Also Hynek Schlawack, [Document your tests](https://hynek.me/articles/document-your-tests/): explanation earns its keep exactly where the why isn't obvious.
