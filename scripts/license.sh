#!/usr/bin/env bash
# Drop a LICENSE at the repo root, fetched from the GitHub licenses API.
#
# Usage, from the repo root:
#   bash .xebec/scripts/license.sh [mit|apache|gpl] ["Copyright Holder"]
#     - license defaults to an interactive pick
#     - holder defaults to `git config user.name`
set -euo pipefail

command -v gh >/dev/null || {
  echo "error: needs the gh CLI -- https://cli.github.com" >&2
  exit 1
}

root=$(git rev-parse --show-toplevel)

choice="${1:-}"
if [[ -z "$choice" ]]; then
  echo "pick a license:  1) MIT   2) Apache-2.0   3) GPL-3.0"
  read -rp "> " choice
fi
case "$choice" in
  1 | mit | MIT) key=mit ;;
  2 | apache | apache-2.0) key=apache-2.0 ;;
  3 | gpl | gpl-3.0) key=gpl-3.0 ;;
  *)
    echo "error: unknown license '$choice' (use mit|apache|gpl)" >&2
    exit 1
    ;;
esac

holder="${2:-$(git config user.name || true)}"
[[ -n "$holder" ]] || read -rp "copyright holder: " holder
year=$(date +%Y)

if [[ -e "$root/LICENSE" ]]; then
  read -rp "LICENSE exists -- overwrite? [y/N] " ok
  [[ "$ok" == [yY] ]] || { echo "kept existing LICENSE."; exit 0; }
fi

body=$(gh api "licenses/$key" --jq '.body')

# Quoted patterns are literal -- bash treats [year] as a glob otherwise. GPL's
# other <...> tokens (URLs, <program>) are instructions, so leave them alone.
case "$key" in
  mit)
    body="${body//'[year]'/$year}"
    body="${body//'[fullname]'/$holder}"
    ;;
  apache-2.0)
    body="${body//'[yyyy]'/$year}"
    body="${body//'[name of copyright owner]'/$holder}"
    ;;
  gpl-3.0)
    body="${body//'<year>'/$year}"
    body="${body//'<name of author>'/$holder}"
    ;;
esac

printf '%s\n' "$body" >"$root/LICENSE"
echo "wrote LICENSE ($key) for $holder, $year"
