# IDEA.md

**Prompts Are Technical Debt.**

Prompts are the worst kind of software. Unlike code -- which throws errors when it breaks -- prompts silently degrade after model upgrades. A phrasing that worked perfectly on a model v4.5 produces subtly worse results on v4.6, and you'll never know unless you're watching closely.

The solution is not better prompts. It's fewer of them. Replace behavior-steering prose with concrete, model-agnostic artifacts that define what the agent should know, not how it should think.

## Problem

Every project hand-rolls prompt instructions for agents. When you open a repo, the agent gets whatever the last developer thought to write in `@CLAUDE.md` or `@AGENTS.md` -- scattered hints, personal preferences, tribal knowledge. There's no shared vocabulary across projects. The same concept gets six different names. When a model upgrade ships, every project's prompt behavior subtly shifts, and no one has tooling to detect it.

Worse: prompts are tuned to one model's quirks. "Think step by step" might help one model and harm another. The same `@AGENTS.md` that produces careful planning on Claude might produce paralysis on GPT. This isn't a bug -- it's the nature of prompts as a medium. They're behavioral, not declarative.

## Approach

Concrete discipline files at predictable paths, each with a single job:

- `@AGENTS.md` -- behavioral contract (principles, not rules)
- `@CONTEXT.md` -- shared language (what things are called, not what they do)
- `@IDEA.md` -- project thesis (why this exists, not what it does)

These are not prompts. They're artifacts. They define the what, never the how. No "think step by step", no "you are a skilled engineer", no role-playing. Just facts and constraints that survive model changes.

## Non-Goals

- Not a prompt engineering framework. No templating, no chaining, no "best practices for writing prompts."
- Not a memory system. Agents remember things; these files define what they should know upfront.
- Not a scaffolding tool. This doesn't generate project boilerplate -- it defines discipline files for projects that already exist.
- Not an agent runtime or SDK. No execution, no tool calling, no MCP integration. Just files on disk.

## Related Work

- **Andrej Karpathy's CLAUDE.md** -- the original "put instructions in a repo file" pattern. **xebec** generalizes this to multiple discipline files with defined formats.
- **Matt Pocock's CONTEXT.md** -- our CONTEXT.md format is directly derived from his domain modeling approach.
