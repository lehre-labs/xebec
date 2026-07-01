---
name: deslopify
description: Remove AI-generated slop from a branch diff -- redundant comments, needless defensive checks, `any` casts, over-nesting, classic Fowler code smells -- and match the surrounding code style. Use when the user wants to clean up a diff before a PR or says "deslopify".
metadata:
  version: "1.1.0"
  authors: ["cursor-team", "matt-pocock", "martin-fowler", "kent-beck", "lehre-labs"]
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

## Fowler Smell Checklist

On top of the focus areas above, check the diff against this fixed baseline of smells from Fowler's *Refactoring* (ch.3) -- each is a judgement call, not a hard violation:

- **Mysterious Name** -- a function, variable, or type whose name doesn't reveal what it does or holds. Rename it.
- **Duplicated Code** -- the same logic shape appears more than once in the diff. Extract the shared shape.
- **Primitive Obsession** -- a primitive or string standing in for a domain concept that deserves its own type. Give the concept its own small type.
- **Speculative Generality** -- abstraction, parameters, or hooks added for needs nothing in the diff has yet. Delete it; inline back until a real need shows.
- **Message Chains** -- long `a.b().c().d()` navigation the caller shouldn't depend on. Hide the walk behind one method.
- **Middle Man** -- a class or function that mostly just delegates onward. Cut it, call the real target direct.

Feature Envy, Data Clumps, Repeated Switches, Shotgun Surgery, Divergent Change, and Refused Bequest are real smells too, but fixing them needs cross-file restructuring, not a minimal in-place edit -- flag them in the summary and point to `/thermo-nuclear-code-quality-review` instead of fixing them here.

## Guardrails

- Keep behavior unchanged unless fixing a clear bug.
- Prefer minimal, focused edits over broad rewrites.
- Keep the final summary concise (1-3 sentences).
