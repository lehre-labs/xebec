---
name: research
description: Web research for engineering work via TinyFish search + fetch_content, grounded in fetched sources.
disable-model-invocation: true
argument-hint: "[deep] <what to research>"
metadata:
  version: "1.0.0"
  authors: ["lehre-labs"]
---

# Research

The one rule: **no load-bearing claim without a source you pulled with `fetch_content`.** A `search` snippet is a lead, never evidence; model memory is never evidence. If you can't fetch a source for a claim, say so instead of asserting it.

Use the project's canonical terms from `@CONTEXT.md` when they apply, so findings speak the repo's language.

<critical>
Default to a single focused pass. Escalate to **deep mode** the moment any of these is true:
- the invocation contains the word `deep`;
- the question is a decision with tradeoffs (library/tool/architecture selection);
- a load-bearing claim is version- or compatibility-specific ("does X support Y", "what changed in vN");
- two sources disagree, or no authoritative source confirms the claim;
- you've fetched ~5 sources and still can't ground the answer;
- the topic is broad or has several independent parts.
When in doubt, go deep -- TinyFish search and fetch_content are free.
</critical>

## Use Cases

```md
Human: /research how do I pin uv to a specific Python version
Human: /research on whether ruff supports per-line noqa ranges
Human: deep /research the MCP streamable-http transport spec
Human: /research deep -- pick a Rust crate for parsing TOML with span info
Human: /research what changed in pydantic v2 model validators
```

## The loop

1. **Search with a purpose.** Run `search` with a `purpose` stating what the result is for. Read titles/snippets only to pick candidates -- never to answer.
2. **Triage to a primary source.** Prefer the authoritative origin: official docs, the spec, the changelog, the project's own repo. A blog or forum answer is a pointer to the primary source, not the source.
3. **Fetch it.** Pull the candidate(s) with `fetch_content` (`format: "markdown"`). Confirm the page actually states the claim and note its version/date when the claim is time-sensitive. See [Fetching](#fetching).
4. **Digest, don't relay.** Do the reading the user would have done: understand the source, infer what it means *for their question and their stack/version*, and form the answer. The source text is your evidence, not your output.
5. **Report** (see [Report](#report)), then **escalate if it resists** -- can't ground a claim, sources conflict, or any `<critical>` trigger fires? Switch to deep mode.

## Report

The skill's job is to **stand in for the user's own reading** -- they asked because they don't want to read five pages. So return the answer, not the pages.

- **Lead with the answer.** First line resolves the question: the yes/no, the version, the recommended choice. Then the *why*, backed by the source.
- **Infer, don't dump.** Translate what the source says into what it means for their situation. "The changelog adds `--frozen` in v0.5" is a fact; "you'll need to bump to v0.5, then add `--frozen` to your lockfile step" is an answer.
- **Quote sparingly.** A load-bearing line or signature when exact wording matters -- never paragraphs. The inline `[url]` lets them go deeper if they want.
- **Be honest about gaps.** Name what you couldn't confirm and what you assumed, so they know the edges of the answer.
- **Match length to the question.** A yes/no gets a few lines; a tool-selection deep dive gets a short comparison. End with a **Sources** list (title -- url, plus date for version/time-sensitive claims).

## Fetching

- **Format.** Fetch with `format: "markdown"` -- clean, token-cheap, built for reading. Use `links: true` only when you need to expand the source tree (deep mode).
- **Keep context lean.** A fetched page can run very long. Read it, then keep only the passage that grounds a claim -- quote at most those load-bearing lines. Never paste a whole page back to the user or carry it forward verbatim. If a page is a giant monolithic index, narrow first: search for the exact sub-page, or follow `links` to the specific section, rather than fetching and re-reading the dump.
- **Blocked or unreachable source -> try a mirror,** then re-fetch:
  - paywalled paper (OpenReview, IEEE, ACM, Elsevier) -> arXiv, then Semantic Scholar;
  - paywalled blog (Medium and friends) -> the author's own site or a dev.to mirror;
  - package page (npm / PyPI / crates.io) that won't render -> the project's GitHub repo (README, `docs/`);
  - docs site that fails to render -> its GitHub source (raw markdown) or a `web.archive.org` snapshot;
  - Stack Overflow blocked -> the official docs or GitHub issue it links to;
  - any page behind a bot-check or JS wall -> prefix the URL with `r.jina.ai/` (free reader, returns clean markdown);
  - last resort for anything -> `web.archive.org`.
- **Public URLs only for mirrors.** `r.jina.ai`, `web.archive.org`, and the rest are third parties -- never route an authed, internal, or otherwise private URL through them; that discloses it. Mirror public pages only.
- **Fallback when TinyFish is unavailable.** If `search`/`fetch_content` aren't installed or authed, fall back to the built-in `WebSearch` and `WebFetch` for the same loop. The one rule is unchanged: ground every claim in a fetched source.

## Deep mode

When escalated:

- **Broaden.** Run several searches across distinct angles, not one query reworded. Fetch many sources; pass `links: true` to `fetch_content` and follow the citations that matter to expand the source tree.
- **Corroborate.** Each load-bearing claim needs two independent sources. Where they disagree, **report the conflict** -- which source, which version, what each says -- don't average it away.
- **Leave a trail.** Write a research note to the OS temp dir (not the workspace, like `/handoff`): the question, queries run, sources (url + date), findings, and open questions. Reference its path in your reply.
- Still answer inline with the same citation contract.
