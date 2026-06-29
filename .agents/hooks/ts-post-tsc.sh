#!/usr/bin/env bash
set -euo pipefail

payload=$(cat)
file_path=$(jq -r '.tool_input.file_path // ""' <<<"$payload")

case "$file_path" in
  *.ts | *.tsx) ;;
  *) exit 0 ;;
esac
[[ -f "$file_path" ]] || exit 0

root=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")
# tsc typechecks the whole project (--noEmit); filter down to the edited file.
output=$(cd "$root" && npx --no-install tsc --noEmit --pretty false 2>&1) || true

# tsc errors: path/file.ts(line,col): error TSxxxx: message
fname=$(basename "$file_path")
file_lines=$(grep -E "$fname\([0-9]+,[0-9]+\): error" <<<"$output") || exit 0

jq -n --arg out "$file_lines" '{
  systemMessage: "tsc: type errors",
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: ("tsc\n" + $out)
  }
}'
