---
name: deslopify
description: Remove AI-generated code slop and clean up code style
metadata:
  version: "1.0.0"
  authors: ["cursor-team", "lehre-labs"]
---

# Remove AI code slop

Check the diff against `main` (default branch) and remove AI-generated slop introduced in the branch.

```md
Human: Go over my branch diff and strip out the AI slop before I open the PR.
Human: This file is full of pointless comments and defensive try/catch -- clean it up.
Human: Deslopify the changes I just made -- match the surrounding code style.
```

## Focus Areas

- Extra comments (micro-context trails, verbose explanations on *what* the code does) that are unnecessary or inconsistent with local style
- Defensive checks or try/catch blocks that are abnormal for trusted code paths
- Casts to `any` used only to bypass type issues
- Literal values that are hardcoded and should be replaced with constants or variables
- Deeply nested, over-engineered code that should be simplified with early returns
- Other patterns inconsistent with the file and surrounding codebase

## Guardrails

- Keep behavior unchanged unless fixing a clear bug.
- Prefer minimal, focused edits over broad rewrites.
- Keep the final summary concise (1-3 sentences).
