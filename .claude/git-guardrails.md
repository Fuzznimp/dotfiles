# Git Guardrails

Never run these git commands — the user handles them:

- `git push` (any variant, including `--force` / `--force-with-lease`)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

If a task genuinely needs one of these, stop and ask the user to run it themselves. Do not work around this by aliasing, scripting, or invoking git through another tool.
