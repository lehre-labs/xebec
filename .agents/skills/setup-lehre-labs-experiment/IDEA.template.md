# {agent-write: Idea Name}

**{agent-write: One sentence -- the bet. Frame it as "problem the agent era exposes -> the experiment that answers it".}**

{agent-write: One-paragraph thesis. The core insight: what changed now that agents read, write, and run code, and why it matters. Think big; stay concrete.}

<thesis-example>
# llmsdottxt-mcp

**`llms.txt` will be how agents read docs -- so serve it to them natively.**

Docs were written for humans skimming a browser. Agents don't skim; they retrieve. `llms.txt` is the emerging convention for agent-readable docs, but nothing serves it over the protocol agents already speak. llmsdottxt-mcp is an MCP server that does.
</thesis-example>

<thesis-example>
# pit

**Git for your agent system prompts -- because prompts are technical debt now.**

Your agents' system prompts are load-bearing software, but git reads them as plain text: a diff shows which words moved, never how the behavior shifted. pit versions agent prompts as first-class artifacts; `pit diff` surfaces the *semantic* drift between two versions -- what the agent will now do differently -- so a one-word edit that quietly changes behavior stops slipping through review.
</thesis-example>

## Problem

{agent-write: What's broken with the status quo, specifically because agents now exist. Concrete examples, not abstractions.}

## Approach

{agent-write: The key insight that makes this experiment different -- not a feature list. The one thing you understood that others didn't.}

## Non-Goals

{agent-write: What this experiment refuses to do. Keep the scope ruthlessly narrow -- one bet, not a platform.}

## Related Work

{agent-write: What else exists, what this builds on or reacts to, and honestly why it exists alongside them -- not why it's "better". Never empty. Need 3-5 WebSearch calls, retry on empty of failed queries.}

<critical>
- One idea per repo. IDEA.md lives at the repo root; there is never more than one.
- The thesis comes first, and every decision traces back to it. If something doesn't serve the idea, it doesn't belong.
- Problem is concrete and agent-era-specific. Don't say "tools are slow" -- show what breaks now that agents are the users.
- Non-Goals are as load-bearing as goals. Be specific about what you will NOT do.
- Related Work is mandatory. Every bet reacts to something.
- Hard cap: one screen of text. IDEA.md is a thesis, not a design doc.
</critical>
