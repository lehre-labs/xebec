# {agent-write: Module Name}

{agent-write: One line -- this module's role in the experiment's big picture. Concrete, not a feature list.}

## Conventions

- {agent-write: Internal patterns this module follows -- naming, data flow, architectural constraints. Module-local, not the project-wide principles (those live in the root AGENTS.md).}

## Gotchas

- {agent-write: Traps. Hidden couplings, async footguns, init quirks, global state. Things that look wrong but aren't, or look right but break.}

## Testing

- {agent-write: Where this module's tests live, how to run them, any setup quirks.}

## Out Of Scope

- {agent-write: What this module deliberately does not handle -- concerns that belong to other modules.}

<critical>
- The file must be named `AGENTS.md` and live in the module directory -- the harness only loads files named `AGENTS.md`. "mini" lives only in this template's name, to mark it as the module-level supplement. The root `AGENTS.md` is the project-wide contract; this one is the module-local micro-context.
- A cheat sheet, not documentation. Each section is a handful of bullets. If it sprawls, the module is doing too much.
</critical>

<critical>
Alongside this module `AGENTS.md`, keep a sibling `CLAUDE.md` whose entire content is the single line `@AGENTS.md`. `AGENTS.md` is canonical; `CLAUDE.md` only includes it, so a harness keyed on either name loads the same module context. Edit `AGENTS.md` only -- never let the two drift.
</critical>
