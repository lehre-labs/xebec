---
name: setup-lehre-labs-experiment
description: Scaffold a new Lehre Labs experiment from the void -- IDEA.md, AGENTS.md, README.md, and the operational context the engineering skills assume. Use when starting a new repo or adding the Lehre Labs discipline files to an existing one.
argument-hint: "[what the experiment is]"
disable-model-invocation: true
metadata:
  version: "1.0.0"
  authors: ["lehre-labs", "matt-pocock"]
---

# Setup Lehre Labs Experiment

Stand up a new Lehre Labs experiment: the discipline files that make the repo legible to humans and agents, plus the operational context the other engineering skills read.

Read [`@LEHRE-LABS.md`](./LEHRE-LABS.md) first -- it's the org identity every experiment inherits. One repo, one idea; think big, build lean; agent-native by default.

This is prompt-driven, not a script. Explore, propose, confirm one decision at a time, then write. Don't fill what you don't know -- a `{agent-write: ...}` placeholder or a question beats a made-up answer.

## Use Cases

```md
Human: Set up a new Lehre Labs experiment here -- the idea is [...].
Human: Scaffold the IDEA/AGENTS/README for this repo.
Human: Add the Lehre Labs discipline files to this existing project.
```

## What this owns

The discipline files, in order. IDEA.md is always first; everything else references it.

| Template | Creates | Audience | When |
| --- | --- | --- | --- |
| `IDEA.template.md` | `IDEA.md` (root) | Everyone | First. The one bet. Never skip. |
| `AGENTS.template.md` | `AGENTS.md` (root) | Agents | Second. The 7-principle contract. |
| `README.template.md` | `README.md` (root) | Humans | After IDEA. Open-source surface. |
| `RTK.md` | `RTK.md` (root) | Agents | Verbatim fallback; `AGENTS.md` imports it. `rtk init -g` regenerates it version-correct. |
| `AGENTS.mini.template.md` | `AGENTS.md` (module dir) | Agents | Lazily, per module with its own conventions or gotchas. |

Operational context the engineering skills consume (carried in this folder, copied into `docs/agents/` on setup):

- [`@DOMAIN.md`](./DOMAIN.md) -- how skills read `CONTEXT.md` and ADRs.
- [`@GITHUB.md`](./GITHUB.md) -- issue-tracker conventions (GitHub via the `gh` CLI).
- [`@TRIAGE-LABELS.md`](./TRIAGE-LABELS.md) -- the five canonical triage roles and their label strings.

## Process

### 1. Explore

Read what already exists; assume nothing.

- The canonical project file (`Cargo.toml`, `pyproject.toml`, `package.json`) -- what's being built, and the language.
- `IDEA.md`, `AGENTS.md`, `CLAUDE.md`, `README.md` at the root -- which exist?
- `git remote -v` -- is this a GitHub repo, and which one?
- `docs/agents/` -- has this skill run here before?

### 2. Draw out the IDEA

The experiment is nothing without its idea. If `IDEA.md` doesn't exist, grill the user until the bet is sharp -- reach for `/grill-me` to interrogate it and `/domain-modeling` to pin the language as it surfaces. Drive toward the Lehre Labs shape:

> {problem the agent era exposes} -> {the experiment that answers it}

If the user can't state it in a sentence, it isn't ready -- say so. Fill `IDEA.template.md` only once the thesis is real.

### 3. Scaffold the discipline files

Write in order, each from its template in this folder. Read the template before using it; replace every `{agent-write: ...}` placeholder, and leave `{TBD}` rather than inventing an answer you don't have.

1. **IDEA.md** -- the bet, the problem, the approach, the non-goals, the related work.
2. **AGENTS.md** -- copy `AGENTS.template.md`, set the project name and canonical project file. Principles 1-7 are canonical; never alter them. Project-specific notes go *below* principle 7, not inside it.
3. **RTK.md** -- copy verbatim from this folder to the repo root. `AGENTS.template.md` already imports it (`@RTK.md`) in a top `<critical>` block, so the token-killer reference is canonical. Then run `rtk init -g` to wire the hook and a version-correct RTK.md; the carried copy is the fallback when the `rtk` binary isn't installed. Per-project filter overrides go in `.rtk/filters.toml` -- only if the repo actually needs them.
4. **CLAUDE.md** -- a one-line clone whose entire content is `@AGENTS.md`. The contract (and the RTK import it now carries) lives in `AGENTS.md`; this just includes it so a harness keyed on either name loads the same thing.
5. **README.md** -- thesis pulled verbatim from IDEA.md.

Create a module `AGENTS.md` (from `AGENTS.mini.template.md`) only lazily -- when a module actually grows its own conventions or gotchas. Never pre-create it. The file must be named `AGENTS.md` for the harness to load it; "mini" lives only in the template name, marking it as the module-level supplement to the root contract. Give it the same one-line `CLAUDE.md` sibling (`@AGENTS.md`).

### 4. Wire the operational context

Pick the file to edit: if `CLAUDE.md` exists, edit it; else if `AGENTS.md` exists, edit it; if neither, ask the user which to create. Never create one when the other already exists.

Add an `## Agent skills` block (update in place if it already exists -- don't append a duplicate), then copy the three context docs into `docs/agents/`:

- `docs/agents/domain.md` from [`@DOMAIN.md`](./DOMAIN.md)
- `docs/agents/issue-tracker.md` from [`@GITHUB.md`](./GITHUB.md) -- or describe the workflow in prose if the repo doesn't use GitHub
- `docs/agents/triage-labels.md` from [`@TRIAGE-LABELS.md`](./TRIAGE-LABELS.md)

Confirm the triage label strings match whatever the repo already uses before writing -- map to existing labels rather than creating duplicates.

```markdown
## Agent skills

### Issue tracker
[where issues are tracked]. See `docs/agents/issue-tracker.md`.

### Triage labels
[the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs
[single-context or multi-context]. See `docs/agents/domain.md`.
```

### 5. Done

Tell the user what was created and which engineering skills now read from these files. They can edit any of it directly later; re-run this skill only to start an experiment over from scratch.
