#!/usr/bin/env bash
set -euo pipefail

payload=$(cat)
file_path=$(jq -r '.tool_input.file_path // ""' <<<"$payload")

case "$file_path" in
  *.ts | *.tsx | *.js | *.jsx | *.mjs | *.cjs) ;;
  *) exit 0 ;;
esac
[[ -f "$file_path" ]] || exit 0

root=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")
output=$(cd "$root" && npx --no-install biome check "$file_path" 2>&1) || true

# Clean runs print "Checked N file(s)" with no diagnostics.
grep -qE '(error|warning)' <<<"$output" || exit 0

jq -n --arg out "$output" '{
  systemMessage: "biome: issues",
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: ("biome\n" + $out)
  }
}'
