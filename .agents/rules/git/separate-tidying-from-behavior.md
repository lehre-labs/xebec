---
name: separate-tidying-from-behavior
description: Keep structure-only changes (tidyings -- renames, extracts, guard clauses, dead-code removal) in their own commit, apart from any commit that changes behavior.
globs: "**/*"
---

- A commit is either structural (no behavior change) or behavioral (changes what the code does) -- never both.
- A mixed commit can't be reviewed or reverted safely: the rename can't be separated from the bug fix riding along with it.
- Tidyings (Kent Beck, *Tidy First?*) -- guard clauses, extracted helpers, renames, dead-code removal, normalized symmetries -- are the structural half; do them as their own commit, before or after the behavioral one.

## Audit Instruction

Re-read `git log <fixed-point>..HEAD --stat` and each commit's diff. Classify every commit as structural or behavioral. Flag any commit that is both -- split it into a tidying commit and a behavior commit before merging.
