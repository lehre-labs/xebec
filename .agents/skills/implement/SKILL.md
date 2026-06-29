---
name: implement
description: "Implement a piece of work based on a PRD, spec, issues or plans."
argument-hint: "[PRD, issue #, or plan to implement]"
disable-model-invocation: true
metadata:
  version: "1.0.1"
  authors: ["matt-pocock", "lehre-labs"]
---

# Implement

Implement the work described by the user in the PRD, spec, issues or plans.

Aware of `.agents/rules/*.md`, `docs/adr/*.md`, `@AGENTS.md` and `@CONTEXT.md`.

Use `/tdd` where possible, at pre-agreed seams.

Run typechecking, formatting, single test files regularly, and the full test suite once at the end.

Once done, use `/deslopify` and `/simplify` in the same session.

We likely need `/handoff` or `/compact` (builtin) to have context headroom for `/code-review`, ask the user explicitly for context.

Only commit your work to the current branch when user has reviewed the work and approved it.

## Use Cases

```md
Human: Implement the PRD in issue #42.
Human: Build out the plan we just grilled -- start at the parser seam.
Human: Pick up the spec in docs/specs/auth.md and implement it.
```
