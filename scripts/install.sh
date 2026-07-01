#!/usr/bin/env bash
# Wire xebec into the repo that submoduled it as .xebec.
#
# Symlinks the shared skills, hooks, and mcp config out of the submodule so
# `git submodule update --remote .xebec` propagates fixes, copies the language
# rules the repo owns into .agents/rules/, and seeds a per-repo
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

mkdir -p "$root/.claude" "$root/.agents/rules"

# .agents/ is the repo's own dir. skills and hooks are shared, so symlink them
# into the submodule -- `git submodule update --remote .xebec` propagates fixes.
ln -sfn ../.xebec/.agents/skills "$root/.agents/skills"
ln -sfn ../.xebec/.agents/hooks  "$root/.agents/hooks"
ln -sfn .xebec/.mcp.json         "$root/.mcp.json"
echo "linked .agents/{skills,hooks}, .mcp.json -> .xebec"

# Rules are copied flat, not symlinked: the repo owns them, can keep its own
# rules alongside, and survives name collisions. Only xebec-*.md are ours, so
# re-running re-syncs our set without touching the repo's own rules.
rm -f "$root/.agents/rules"/xebec-*.md
synced=0
for lang_dir in "$xebec/.agents/rules"/*/; do
  case "$(basename "$lang_dir")" in
    rust)       [[ -f "$root/Cargo.toml" ]] || continue ;;
    python)     [[ -f "$root/pyproject.toml" ]] || continue ;;
    typescript) [[ -f "$root/package.json" || -f "$root/tsconfig.json" ]] || continue ;;
    git)        ;; # language-agnostic, always applies
    *)          continue ;;
  esac
  for rule in "$lang_dir"*.md; do
    [[ -e "$rule" ]] || continue
    cp "$rule" "$root/.agents/rules/xebec-$(basename "$rule")"
    synced=$((synced + 1))
  done
done
if [[ $synced -gt 0 ]]; then
  echo "copied $synced xebec rule(s) -> .agents/rules/xebec-*.md"
else
  echo "no xebec rules match this repo's languages -- add your own in .agents/rules/"
fi

# .claude/ mirrors .agents/ so the harness finds skills, hooks, and rules.
ln -sfn ../.agents/skills "$root/.claude/skills"
ln -sfn ../.agents/hooks  "$root/.claude/hooks"
ln -sfn ../.agents/rules  "$root/.claude/rules"
echo "linked .claude/{skills,hooks,rules} -> .agents"

# Issue/PR templates only -- .github/workflows stays the repo's own.
mkdir -p "$root/.github"
ln -sfn ../.xebec/.github/ISSUE_TEMPLATE          "$root/.github/ISSUE_TEMPLATE"
ln -sfn ../.xebec/.github/PULL_REQUEST_TEMPLATE.md "$root/.github/PULL_REQUEST_TEMPLATE.md"
echo "linked .github/{ISSUE_TEMPLATE,PULL_REQUEST_TEMPLATE.md} -> .xebec"

# Per-repo and editable -- seed once, never clobber.
if [[ -e "$root/.claude/settings.json" ]]; then
  echo "kept existing .claude/settings.json"
else
  cp "$xebec/.claude/settings.json" "$root/.claude/settings.json"
  echo "seeded .claude/settings.json (yours to edit)"
fi

echo "done. open Claude Code and run /setup-lehre-labs-experiment"
