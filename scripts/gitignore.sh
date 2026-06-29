#!/usr/bin/env bash
# Fetch .gitignore templates from github/gitignore into the repo root.
#
# Usage, from the repo root:
#   bash .xebec/scripts/gitignore.sh <Template...>      # overwrite (default)
#   bash .xebec/scripts/gitignore.sh -a <Template...>   # append instead
#   bash .xebec/scripts/gitignore.sh -l [query]         # list / search templates
#
# Template names are case-insensitive (python -> Python.gitignore); pass several
# to concatenate (e.g. Python Rust). Arg-driven, no prompts -- an agent runs it.
set -euo pipefail

command -v gh >/dev/null || {
  echo "error: needs the gh CLI -- https://cli.github.com" >&2
  exit 1
}

repo=github/gitignore
root=$(git rev-parse --show-toplevel)
list() { gh api "repos/$repo/contents" --jq '.[].name | select(endswith(".gitignore")) | rtrimstr(".gitignore")'; }

mode=overwrite
case "${1:-}" in
  -l | --list)
    shift
    if [[ $# -gt 0 ]]; then list | grep -i "$1" || true; else list; fi
    exit 0
    ;;
  -a | --append) mode=append; shift ;;
  -o | --overwrite) shift ;;
esac

[[ $# -gt 0 ]] || {
  echo "usage: gitignore.sh [-a|-l] <Template...>" >&2
  exit 1
}

names=$(list)
body=""
for want in "$@"; do
  match=$(printf '%s\n' "$names" | grep -ix "$want" || true)
  [[ -n "$match" ]] || {
    echo "error: no template '$want' (run with -l to search)" >&2
    exit 1
  }
  text=$(gh api -H "Accept: application/vnd.github.raw" "repos/$repo/contents/$match.gitignore")
  body+="### $match.gitignore ###"$'\n'"$text"$'\n\n'
done

target="$root/.gitignore"
if [[ "$mode" == append && -e "$target" ]]; then
  printf '%s' "$body" >>"$target"
  echo "appended $* to .gitignore"
else
  printf '%s' "$body" >"$target"
  echo "wrote .gitignore ($*)"
fi
