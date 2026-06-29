# Lehre Labs

An experimental engineering lab. Every repo here is one **experiment** paired with one **idea** -- a sharp bet about how software should work now that agents read, write, and run it.

## How we work

- **One repo, one idea.** Each experiment starts from a single thesis in `IDEA.md`: something the old world got wrong, and the thing we build to fix it. If you can't state the idea in a sentence, it isn't an experiment yet.
- **Problem first, then the build.** The idea names what's broken *because agents now exist*; the experiment is the smallest thing that proves the fix.
- **Think big, build lean.** Ambitious bets, ruthlessly small surface area. Every file earns its place.
- **Agent-native by default.** We build for a world where agents are first-class users -- not as an afterthought bolted onto a human tool.

## The shape of an idea

> {problem the agent era exposes} -> {the experiment that answers it}

- *`llms.txt` will be how agents read docs* -> **llmsdottxt-mcp**, an MCP server that serves it.
- *a prompt edit is a behavior change git can't see* -> **pit**, git for your agent system prompts; `pit diff` shows the semantic drift, not just the text.

Each experiment is a wager that one of these holds. Most won't. The ones that do become the next thing we build on.
