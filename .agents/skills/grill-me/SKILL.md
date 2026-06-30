---
name: grill-me
description: Interview the user relentlessly about a PRD, SPEC or PLAN. Use when the user wants to stress-test a plan before building, or uses any 'grill' trigger phrases.
argument-hint: "[PRD # | spec path | plan path]"
disable-model-invocation: true
metadata:
  version: "1.0.1"
  authors: ["matt-pocock"]
---

# Grill Me

Interview me relentlessly about every aspect of this PRD, SPEC or PLAN until we reach a **shared understanding**. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your **recommended** answer.

Ask the questions one at a time, waiting for feedback on each question before continuing. Asking multiple questions at once is bewildering.

If a question can be answered by exploring the codebase, explore the codebase instead.

## Use Cases

```md
Human: Grill me on this PRD before I hand it to an agent.
Human: Here's my plan for the auth refactor -- poke holes in it until it's solid.
Human: I think the spec is done. Interview me until we actually agree on it.
```

## Context Awareness

Before grilling, load the project's shared language so your questions use the team's terms, not invented ones -- shared language is what makes the resulting understanding *shared*.

- **`@AGENTS.md`** -- the project's principles. Grill within them; don't float options that violate a stated principle.
- **`@CONTEXT.md`** -- the glossary / ubiquitous language. Use these canonical terms in every question. If the user reaches for a fuzzy or conflicting term, challenge it on the spot (a `/domain-modeling` moment) instead of letting it slide. A term you need but can't find is itself an unresolved question -- surface it.
- **`@CONTEXT-MAP.md`** -- if it exists, the repo has multiple contexts. Work out which one the PRD/SPEC/PLAN belongs to, grill within its boundaries, and flag cross-context dependencies explicitly.
