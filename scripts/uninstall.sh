#!/usr/bin/env bash
# Remove the xebec wiring from this repo. Only deletes the symlinks install.sh
# created -- your .claude/settings.json and the .xebec submodule are left alone.
#
# Usage, from the consuming repo root:  bash .xebec/scripts/uninstall.sh
set -euo pipefail

root=$(git rev-parse --show-toplevel)

for link in .agents .claude/skills .claude/hooks .mcp.json \
  .github/ISSUE_TEMPLATE .github/PULL_REQUEST_TEMPLATE.md; do
  if [[ -L "$root/$link" ]]; then
    rm "$root/$link"
    echo "removed $link"
  fi
done

echo "unwired. .claude/settings.json and .xebec left intact."
