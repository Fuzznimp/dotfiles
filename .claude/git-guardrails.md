# Git Guardrails

Never run these git commands, the user handles them:

- `git push` (any variant, including `--force` / `--force-with-lease`)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

If a task genuinely needs one of these, stop and ask the user to run it themselves. Do not work around this by aliasing, scripting, or invoking git through another tool.

## Ask before rewriting history

Never run `git commit --amend`, `git rebase` (any form, `--exec` included), `git commit --fixup`/`--squash` followed by autosquash, or anything else that rewrites existing commits, without the user's explicit go for that specific rewrite. Propose it, explain why, wait.

## Commits

Commit finished work yourself, without being asked: once the change is done and the checks pass (lint, types, tests), commit it, one commit per group from the split (see programming.md). Conventional commit messages, no AI attribution line. Report the commit hashes.

Do not commit unverified or half-done work. The user owns pushes, tags and PRs: do not offer them as next steps, do not remind the user to push.
