#!/usr/bin/env bash
set -euo pipefail

payload=$(cat)
file_path=$(jq -r '.tool_input.file_path // ""' <<<"$payload")

[[ "$file_path" == *.rs ]] || exit 0
[[ -f "$file_path" ]] || exit 0

root=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")
output=$(cd "$root" && rustfmt --check "$file_path" 2>&1) || true

# rustfmt --check outputs "Diff in <file>" when there are formatting issues
grep -q 'Diff in ' <<<"$output" || exit 0

jq -n --arg out "$output" '{
  systemMessage: "rustfmt: formatting issues",
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: ("rustfmt\n" + $out)
  }
}'
