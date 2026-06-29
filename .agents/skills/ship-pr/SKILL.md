---
name: ship-pr
argument-hint: "[--issue N] [--draft] [--auto-merge] [--title <text>]"
description: Ship the current branch as a GitHub PR -- commit staged work, push, open a PR from the repo template, report CI, optionally arm auto-merge. Use when the user says "ship it", "open a PR", "create a PR", or "push and PR".
disable-model-invocation: true
metadata:
  version: "1.0.0"
  authors: ["lehre-labs"]
---

# Ship PR

One predictable path from a working branch to an open GitHub PR: commit -> push -> PR from the template -> CI. No history rewriting, no force pushes, no stashing -- every step is one you could run by hand and trust.

Uses the `gh` CLI (see [`@docs/agents/issue-tracker.md`](../../../docs/agents/issue-tracker.md) if present) and fills `.github/PULL_REQUEST_TEMPLATE.md`.

## Use Cases

```md
Human: Ship this branch as a PR.
Human: Open a PR for the work and link issue #42.
Human: Push and create a draft PR for early feedback.
Human: Create the PR and arm auto-merge once checks pass.
```

## Flags

- `--issue <N>` -- link an existing issue; the PR closes it.
- `--draft` -- open the PR as a draft.
- `--auto-merge` -- arm GitHub auto-merge after required checks pass (invalid with `--draft`).
- `--title <text>` -- override the generated PR title.

Default (no flags): commit staged work, push the branch, open a ready PR against the default branch.

## Safety -- what this never does

- Never `git push --force` or `--force-with-lease`. The branch only fast-forwards. A non-fast-forward rejection is a STOP, not a force.
- Never `git stash`. A dirty tree gets surfaced, not hidden.
- Never `git add .`. Stage only the files you changed for this task; generated or unrelated edits stay unstaged and get named.
- Never rebases or rewrites pushed history. Branch behind the base? Merge the base in (a normal push) -- don't rebase.
- No attribution trailers in the commit or the PR body (`Co-Authored-By`, "Generated with ...").

## Process

### 1. Preflight

Find the default branch once -- `gh repo view --json defaultBranchRef --jq .defaultBranchRef.name` (usually `main`); everything targets it. Then read state together (independent, one message):

```
gh auth status
git status --short
git log --oneline <default-branch>..HEAD
```

If you're on the default branch with changes to commit, branch first (step 3) -- never commit onto the default branch.

### 2. Commit (if there are uncommitted changes)

Stage only what you changed for this task. Write a conventional commit -- product-first subject, why-body:

```
git commit -m "$(cat <<'EOF'
<type>(<scope>): <user-visible outcome>

<what changed and why>

Closes #<issue-number>
EOF
)"
```

Drop the `Closes` line when there's no linked issue. No trailers.

### 3. Branch (only if on the default branch)

```
git checkout -b <type>/<short-topic>   # e.g. fix/token-expiry
```

kebab-case, derived from the commits. Already on a feature branch? Keep it.

### 4. Push

```
git push -u origin "$(git branch --show-current)"
```

A plain fast-forward push. If the remote rejects it as non-fast-forward, STOP and surface it -- never force.

### 5. Open the PR from the template

Fill `.github/PULL_REQUEST_TEMPLATE.md`. Write the body to a temp file and pass `--body-file`, so backticks in the template are never run by the shell:

```
gh pr create --base <default-branch> --title "<title>" --body-file <scratch-path> [--draft]
```

- **Title**: a plain sentence, no `type(scope):` prefix -- take the dominant commit subject and strip the prefix.
- **Checklist**: tick only the boxes you actually satisfied (serves the IDEA, surgical, tests pass, ADR if a hard-to-reverse decision landed). Honest boxes, not all-checked.
- **Closes #<N>**: point it at the linked issue, or remove the line if there is none. Never fabricate a number.

### 6. Report CI

```
gh pr checks <N>
```

Report pass / fail / pending. If a required check fails, read it (`gh run view <id> --log-failed`), fix, commit, push -- the PR updates in place. Never merge on red.

### 7. Auto-merge (only if --auto-merge)

Invalid with `--draft`. Arm GitHub's native auto-merge -- the platform merges once required checks and reviews pass, and refuses on red or unreviewed:

```
gh pr merge <N> --auto --squash   # match the repo's merge policy: --squash | --merge | --rebase
```

If the repo hasn't enabled auto-merge, `gh` errors -- surface it, leave the PR open. Report that it's armed; don't block waiting.

### 8. Report

Branch, PR URL, CI status, and whether auto-merge is armed.

## Out of scope

- History rewriting -- rebase, branch rename, force-push. Excluded by design; to catch a branch up to its base, merge the base in (normal push).
- Issue creation and triage. Pass `--issue <N>` to link an existing one; use `/write-prd` to file a fresh ticket first.
- Blocking review loops. Use `gh pr checks <N> --watch` if you want to wait on CI.
