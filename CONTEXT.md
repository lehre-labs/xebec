# Context: xebec

The vocabulary xebec uses for itself -- the artifacts it ships, the units they are made of, and the agent surfaces they target. xebec is a toolkit *about* agent discipline, so its domain is that discipline, not any one product.

## Core concepts

**Prompt**:
Behavior-steering prose that tells an agent *how* to think ("think step by step", "you are a skilled engineer"). xebec treats prompts as technical debt and exists to replace them.
_Avoid_: instruction, system message (when you mean steering prose)

**Artifact**:
A concrete, model-agnostic file stating *what* an agent should know -- facts and constraints that survive model upgrades. The deliberate opposite of a Prompt.
_Avoid_: config, doc, prompt

**Harness**:
The agent runtime that loads a repo's files and runs an agent against them (e.g. Claude Code). It decides which filenames it reads; xebec only writes files the harness already looks for.
_Avoid_: runtime, agent, IDE, client

## Org and repos

**Lehre Labs**:
The lab. Every repo under it is one Experiment paired with one IDEA.
_Avoid_: org, company

**Experiment**:
A single repo: one sharp bet, ruthlessly scoped. The unit of work in Lehre Labs.
_Avoid_: project, app, product

**IDEA**:
The one bet an Experiment is built around, stated in `IDEA.md` as "problem the agent era exposes -> the experiment that answers it". Exactly one per repo.
_Avoid_: thesis, vision, goal, spec

## Discipline files

**Discipline file**:
An Artifact at a predictable repo path that makes the repo legible to humans and agents: `IDEA.md`, `AGENTS.md`, `CONTEXT.md`, `CONTEXT-MAP.md`, `README.md`.
_Avoid_: config, doc, dotfile

**AGENTS.md**:
The behavioral contract -- the project's Principles. `CLAUDE.md` is only a one-line clone (`@AGENTS.md`); AGENTS.md is canonical and the two never drift.
_Avoid_: CLAUDE.md, rules, prompt

**CONTEXT.md**:
This file: the glossary of a context's ubiquitous language, and nothing else -- no implementation detail, no decisions. A `CONTEXT-MAP.md` at the root means the repo has several contexts, each with its own CONTEXT.md.
_Avoid_: docs, spec, README, notes

**Principle vs Rule**:
A Principle is a judgment call in `AGENTS.md` (how to think). A Rule is an enforceable, checkable constraint in `.agents/rules/` (what must or must not happen). Don't call one the other.
_Avoid_: guideline, convention (when the distinction matters)

**ADR**:
An Architecture Decision Record in `docs/adr/` -- a record that a hard-to-reverse, non-obvious, traded-off decision was made, and why.
_Avoid_: design doc, RFC, spec

## Reusable units

**Skill**:
A repeatable engineering procedure shipped as files under a `SKILL.md` (TDD, writing an ADR, shipping a PR). Either explicit (`disable-model-invocation: true`, run by name) or auto (triggered by its description).
_Avoid_: command, tool, agent, prompt

**Hook**:
A script the Harness runs around a tool call -- the post-edit linters and the pre-bash rtk rewrite.
_Avoid_: plugin, middleware, script (when you mean a Harness hook)

**Template**:
A pure Artifact (`*.template.md`) a Skill fills to scaffold a Discipline file. Carries `{agent-write:}` placeholders and `<...-example>` blocks, with no meta-wrapper around them.
_Avoid_: boilerplate, scaffold, stub

**agent-write placeholder**:
A `{agent-write: ...}` slot in a Template marking what the agent must compose. Distinct from `{TBD}`, which marks an answer not yet known.
_Avoid_: fill-in, TODO, blank

## Shipping into a repo

**Wiring**:
Linking xebec's shared Artifacts from the `.xebec` submodule into a consuming Experiment, so a single xebec update propagates to every repo.
_Avoid_: install, vendoring, copying

**Module AGENTS.md**:
A per-module micro-context file. It is always named `AGENTS.md`; "mini" lives only in its template's name. It supplements, never replaces, the root AGENTS.md.
_Avoid_: AGENTS-MINI, sub-AGENTS, local config
