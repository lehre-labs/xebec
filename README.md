# xebec

> Prompts Are Technical Debt.

A git submodule of agent discipline: a behavioral contract and context-file templates, a dozen engineering skills (TDD, ADRs, domain modeling, debugging, code review), post-edit lint hooks, and MCP server config. Drop it into a repo, wire it in once, and the `setup-lehre-labs-experiment` skill scaffolds the discipline files for a fresh experiment.

## Quickstart

From a new repo's root:

```bash
git submodule add <xebec-remote-url> .xebec
bash .xebec/scripts/install.sh
```

`install.sh` symlinks the shared `.agents` tree, the `.claude/{skills,hooks}` Claude Code reads, `.mcp.json`, and the `.github` issue/PR templates out of the submodule (so `git submodule update` propagates fixes) and seeds a per-repo `.claude/settings.json` that stays yours to edit. Your `.github/workflows` stay your own. Then, in Claude Code:

```
/setup-lehre-labs-experiment
```

to draw out the idea and scaffold `IDEA.md`, `AGENTS.md`, and `README.md`.

Pull the latest discipline into an existing repo with `git submodule update --remote .xebec`. To unwire, `bash .xebec/scripts/uninstall.sh` removes the symlinks and leaves your settings and the submodule intact.

### Tell your contributors

Because the wiring lives in the submodule, a plain clone leaves `.xebec` empty and the `.claude` skill/hook symlinks dangling. Add a line to your repo's own README so contributors clone right (the `/setup-lehre-labs-experiment` skill already seeds it into scaffolded READMEs):

> Clone with `git clone --recurse-submodules` (or run `git submodule update --init`). `.xebec` is agent tooling -- not needed to build or test.

## Known Limitations

- Submodules need `git clone --recurse-submodules` (or `git submodule update --init`) -- a plain clone gets an empty `.xebec`.
- The wiring symlinks (`.agents`, `.claude/skills`, `.claude/hooks`, `.mcp.json`) assume a POSIX filesystem; Windows needs symlink support enabled.
- Hooks no-op unless their tools are on PATH: `rtk` for the bash hook, `ruff`/`ty`/`basedpyright`, `cargo`/`rustfmt`, `biome`/`tsc` for the lint hooks.
- `.mcp.json` expects `pgr` at `${HOME}/.cargo/bin/pgr` -- the code-search server won't start without it.
