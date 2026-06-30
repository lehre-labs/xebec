#!/usr/bin/env bash
# Remove the xebec wiring from this repo. Deletes the symlinks and the copied
# xebec-*.md rules install.sh created -- your .claude/settings.json, your own
# .agents/rules, and the .xebec submodule are left alone.
#
# Usage, from the consuming repo root:  bash .xebec/scripts/uninstall.sh
set -euo pipefail

root=$(git rev-parse --show-toplevel)

for link in .agents/skills .agents/hooks .claude/skills .claude/hooks \
  .claude/rules .mcp.json .github/ISSUE_TEMPLATE .github/PULL_REQUEST_TEMPLATE.md; do
  if [[ -L "$root/$link" ]]; then
    rm "$root/$link"
    echo "removed $link"
  fi
done

# Copied rules are ours (xebec-*.md); the repo's own rules stay.
rm -f "$root/.agents/rules"/xebec-*.md
rmdir "$root/.agents/rules" "$root/.agents" 2>/dev/null || true

echo "unwired. .claude/settings.json, your own rules, and .xebec left intact."
