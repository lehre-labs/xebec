---
name: manage-github
description: View, filter, search, create, and export GitHub issues with the gh CLI. Creates issues unassigned unless you name an assignee, and only ever uses labels that already exist. Use to triage, list, count, search, or file issues.
argument-hint: "[what to do with issues]"
metadata:
  version: "1.0.0"
  authors: ["lehre-labs"]
---

# Manage GitHub Issues

Drive GitHub issues through the `gh` CLI -- list, filter, search, view, create, export. See [`@docs/agents/issue-tracker.md`](../../../docs/agents/issue-tracker.md) for this repo's conventions and [`@docs/agents/triage-labels.md`](../../../docs/agents/triage-labels.md) for its label vocabulary (if those have been wired in).

`gh` is the whole toolkit -- no helper scripts. It filters server-side, `--json` gives clean structured output, and it rejects unknown labels on its own, so the label discipline is enforced for you.

## Use Cases

```md
Human: Show me the open issues.
Human: List the ready-for-agent issues.
Human: How many open issues need triage?
Human: Find issues about authentication.
Human: Create an issue for the flaky export test.
Human: Export all open issues to JSON.
```

## First, auth

```
gh auth status
```

Not authenticated -> tell the user to run `gh auth login`, then stop.

## Intent -> command

| User wants | Command |
| --- | --- |
| All open issues | `gh issue list --state open` |
| My issues | `gh issue list --assignee @me` |
| By label | `gh issue list --label ready-for-agent` |
| Search text | `gh issue list --search "authentication in:title,body"` |
| One issue + thread | `gh issue view <N> --comments` |
| Count / summary | `gh issue list --state open --json labels --jq '[.[].labels[].name] | group_by(.) | map({(.[0]): length})'` |
| Export | `gh issue list --state open --limit 1000 --json number,title,state,labels,assignees,createdAt > issues.json` |
| Create | `gh issue create ...` (see below) |

No pagination loops, no manual JSON parsing -- `--json` + `--jq` and `--limit` cover it.

## Creating an issue

1. **Use a template when one fits** (`.github/ISSUE_TEMPLATE/`): `bug_report` follows the diagnose-bugs shape (a command that goes red); `feature_request` is the seed for a `/write-prd`. Write the body to a temp file and pass `--body-file` so backticks in the body aren't run by the shell.
2. **Unassigned by default.** Omit `--assignee` unless the user names someone -- then `--assignee <user>` or `--assignee @me`. Don't silently take ownership; it muddies backlog triage.
3. **Only existing labels.** `gh label list` shows the repo's set, and `gh` errors on any label that doesn't exist -- so never invent one. Map to what's there (`docs/agents/triage-labels.md`: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). A new label is a separate discussion, not an ad-hoc creation.

```
gh issue create \
  --title "<title>" \
  --body-file <scratch-path> \
  --label needs-triage
```

A fresh issue defaults to `needs-triage`. Mark it `ready-for-agent` only when it's already scoped enough for an agent to pick up with no further questions.

## Reporting back

Lead with the answer -- the list, the count, the new issue URL. Name the command you used so the user can reuse it, and suggest the obvious next step (a tighter filter, an export, or `/write-prd` to flesh a feature out).

## Out of scope

- Pull requests -- `/ship-pr` opens one; `gh pr ...` for the rest.
- Milestones, projects, and labels as configuration -- define those in repo settings. This skill consumes the existing vocabulary; it doesn't create it.
