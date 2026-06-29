---
name: write-adr
description: Write an Architecture Decision Record. Use when the user wants to record a decision, says "let's write an ADR", or a decision lands that meets the three criteria.
metadata:
  version: "0.1.0"
  authors: ["lehre-labs"]
---

# Write ADR

Write an Architecture Decision Record at the moment a decision lands. An ADR records *that* a decision was made and *why* -- nothing more.

## When to write one

All three criteria must be true:

1. **Hard to reverse** -- the cost of changing your mind later is meaningful.
2. **Surprising without context** -- a future reader will wonder "why did they do it this way?"
3. **Result of a real trade-off** -- there were genuine alternatives and you picked one for specific reasons.

If any is missing, skip the ADR. Easy-to-reverse choices, obvious decisions, and things with no real alternative don't need one.

## Where to write one

Always in `docs/adr/`. Create the directory lazily -- only when the first ADR is needed.

## How to write one

First, scan `docs/adr/` for the highest existing number, increment by one, and create `NNNN-slug.md`.

Then, use the template below to write an ADR: [`@ADR.template.md`](./ADR.template.md).

## What qualifies

- **Architectural shape.** Monorepo vs polyrepo, event-sourced vs CRUD.
- **Integration patterns between contexts.** Domain events vs synchronous HTTP.
- **Technology choices with lock-in.** Database, message bus, auth provider.
- **Boundary and scope decisions.** Who owns what data.
- **Deliberate deviations from the obvious path.** Anything a reasonable reader would assume the opposite of.
- **Constraints not visible in code.** Compliance, budget, team bandwidth.
- **Rejected non-obvious alternatives.** If someone will suggest it again in six months, record why you said no.
