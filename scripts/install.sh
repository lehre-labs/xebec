#!/usr/bin/env bash
# Wire xebec into the repo that submoduled it as .xebec.
#
# Symlinks the shared skills, hooks, and mcp config out of the submodule so
# `git submodule update --remote .xebec` propagates fixes, and seeds a per-repo
# .claude/settings.json you own. Idempotent -- safe to re-run.
#
# Usage, from the consuming repo root:  bash .xebec/scripts/install.sh
set -euo pipefail

root=$(git rev-parse --show-toplevel)
xebec="$root/.xebec"

[[ -d "$xebec" ]] || {
  echo "error: no .xebec submodule at repo root." >&2
  echo "  run first:  git submodule add <xebec-remote-url> .xebec" >&2
  exit 1
}

mkdir -p "$root/.claude"

# Shared and versioned in the submodule -- symlink so updates flow through.
ln -sfn .xebec/.agents           "$root/.agents"
ln -sfn ../.xebec/.agents/skills "$root/.claude/skills"
ln -sfn ../.xebec/.agents/hooks  "$root/.claude/hooks"
ln -sfn .xebec/.mcp.json         "$root/.mcp.json"
echo "linked .agents, .claude/skills, .claude/hooks, .mcp.json -> .xebec"

# Per-repo and editable -- seed once, never clobber.
if [[ -e "$root/.claude/settings.json" ]]; then
  echo "kept existing .claude/settings.json"
else
  cp "$xebec/.claude/settings.json" "$root/.claude/settings.json"
  echo "seeded .claude/settings.json (yours to edit)"
fi

echo "done. open Claude Code and run /setup-lehre-labs-experiment"
