# Git Guardrails

Never run these git commands — the user handles them:

- `git push` (any variant, including `--force` / `--force-with-lease`)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

If a task genuinely needs one of these, stop and ask the user to run it themselves. Do not work around this by aliasing, scripting, or invoking git through another tool.

## Never suggest versioning steps

The user owns commits, branches, tags, PRs, and pushes. Do not offer them as next steps, do not ask whether to commit or push, do not remind the user that changes are uncommitted. No "next: your call on committing", no "want me to commit this?", no "don't forget to push".

State what changed and whether it works. Stop there. If the user wants a commit, they ask.
