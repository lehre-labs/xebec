#!/usr/bin/env bash
set -euo pipefail

payload=$(cat)
file_path=$(jq -r '.tool_input.file_path // ""' <<<"$payload")

[[ "$file_path" == *.py ]] || exit 0
[[ -f "$file_path" ]] || exit 0

root=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")
output=$(cd "$root" && uv run basedpyright "$file_path" 2>&1) || true

# Lines with issues: indent, rel-path:line:col - level: message
# Drop header (absolute path) and summary ("N errors...")
file_lines=$(grep -E ' - (error|warning):' <<<"$output") || exit 0

jq -n --arg out "$file_lines" '{
  systemMessage: "basedpyright: issues",
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: ("basedpyright\n" + $out)
  }
}'
