---
name: write-prd
description: Turn the current conversation into a PRD and publish it to the project issue tracker -- no need to grill the user, just synthesis of what you've already discussed.
disable-model-invocation: true
metadata:
  version: "1.0.1"
  authors: ["matt-pocock", "lehre-labs"]
---

# Write PRD

This skill takes the current conversation context and codebase understanding and produces a PRD. Do NOT grill the user -- just synthesize what you already know.

NOTE: The issue tracker and triage label vocabulary should have been provided to you -- if not, run `/setup-pre-triage`.

## Use Cases

```md
Human: Okay, turn everything we just discussed into a PRD.
Human: We've scoped the bulk-export feature enough -- draft the PRD and file it.
Human: Write this up as a ticket an agent can pick up.
Human: Make a PRD for the changes we agreed on and put it in the tracker.
```

## Process

1. Explore the repo to understand the current state of the codebase, if you haven't already. Use the project's domain glossary vocabulary throughout the PRD, and respect any ADRs in the area you're touching.

2. Sketch out the seams at which you're going to test the feature. Existing seams should be preferred to new ones. Use the highest seam possible. If new seams are needed, propose them at the highest point you can. The fewer seams across the codebase, the better -- the ideal number is one.

Check with the user that these seams match their expectations.

3. Write the PRD using the template [`@PRD.template.md`](./PRD.template.md), then publish it to the project issue tracker. Apply the `ready-for-agent` triage label -- no need for additional triage.
