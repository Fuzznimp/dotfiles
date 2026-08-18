# tmux Guardrails

## Never kill anything in tmux

Never run any `tmux kill-*` command. This includes, and is not limited to:

- `tmux kill-session` (with or without `-t`, `-a`)
- `tmux kill-server`
- `tmux kill-window`
- `tmux kill-pane`

The user works inside tmux. A wrong or stale target name, a session that was renamed, or a target that resolves to the current session destroys live work with no undo. "I only created that session myself" is not a safe exception: the target may not be what you think by the time the command runs.

This holds even for sessions, windows or panes you created yourself during the task. Leave them in place and tell the user what is left over, so they can clean up. If a task genuinely needs something killed, stop and ask the user to run it themselves.

Do not work around this by aliasing, scripting, `send-keys` typing the command into a pane, or invoking tmux through another tool.

## Testing tmux tools

When a task needs a scratch session, window or pane to test against:

- Create it with a name that cannot collide with the user's sessions.
- Never target the user's sessions with mutating commands.
- Leave cleanup to the user, and say plainly what was created.
