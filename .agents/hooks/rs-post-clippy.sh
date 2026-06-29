#!/usr/bin/env bash
set -euo pipefail

payload=$(cat)
file_path=$(jq -r '.tool_input.file_path // ""' <<<"$payload")

[[ "$file_path" == *.rs ]] || exit 0
[[ -f "$file_path" ]] || exit 0

root=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")

output=$(cd "$root" && cargo clippy --workspace --message-format=short 2>&1) || true

# Filter lines referencing this file: src/file.rs:line:col: level: message
fname=$(basename "$file_path")
file_lines=$(grep -E "^[^ ]*$fname:[0-9]+:[0-9]+: (error|warning)" <<<"$output") || exit 0

jq -n --arg out "$file_lines" '{
  systemMessage: "cargo clippy: issues",
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: ("clippy\n" + $out)
  }
}'
