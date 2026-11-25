# Enforcing programming.md at write time

## Implemented: comments

`hooks/check-comments.mjs`, wired in `settings.json`:

- `PostToolUse` on `Write|Edit|MultiEdit` (`check-comments.mjs edit`): lists the comments the edit added to a JS/TS file (`.d.ts` and `node_modules` skipped, lint directives ignored) with the "Comments" checklist of `programming.md`, fed back to Claude as a blocking review. Only comments new to that edit, so a kept comment is not flagged again.
- `PreToolUse` on `Bash` (`check-comments.mjs commit`): denies a `git commit` whose staged diff adds comments (whole diff vs `HEAD` plus untracked files when the same command runs `git add`), listing them with file and line. Rerunning with `COMMENTS_REVIEWED=1 git commit …` lets it through. Catches comments written by shell scripts, which bypass `Write`/`Edit`.

The other checks below are still to do.

## Problem

Claude follows `programming.md` when it reads it, then drifts back to its own defaults as soon as it writes a file. The rules are loaded once at session start (and restated each turn by the `UserPromptSubmit` hook), but the moment of failure is the `Write`/`Edit` call, where nothing re-checks them.

Observed in a single session (2026-09-25, cereal protection `SOWING_SCHEDULED` work):

- doc comments added on `hasCropStarted`, on `CerealProtection.sowingDate`, on `setAsSowed`, and a class-level comment on a new builder, all restating what the name already said. The rule asks for non-obvious information only.
- file paths written inside code blocks in replies instead of on the line above them.

The user's summary: "You often diverge from this file rules, I hate it."

Conversation-level reminders are not sufficient. The `UserPromptSubmit` hook already injects a condensed rule list every turn, including "COMMENTS: only non-obvious info", and the violations still happened.

## Why a hook is the right fix

A hook fires deterministically, at the exact tool call, and its output lands in context as tool feedback. It does not depend on Claude re-reading anything.

Two candidate points:

| Hook | Effect | Value |
| --- | --- | --- |
| `PreToolUse` on `Write\|Edit` | injects the checklist just before the file is written | reminder at the right instant, still relies on attention |
| `PostToolUse` on `Write\|Edit` | runs a checker over what was just written and reports violations | actual enforcement, independent of attention |

`PostToolUse` is the one that changes outcomes. `PreToolUse` is a cheap complement.

## Checks worth automating

Run against the file path from the tool payload, only for `.ts` / `.tsx` under `src/`:

1. **Comments**: any added `/** … */` block or `//` line. Crude by design: Claude then has to justify keeping each one rather than adding them by reflex.
2. **Function declarations**: module-level `const name = (…) =>` in `.ts`. Allowed exceptions: `.tsx` React components, and consts annotated with a full function type (`const x: SomeFn = …`).
3. **Array syntax**: `: SomeType[]` instead of `Array<SomeType>`.
4. **Props type**: `type Props =` in `.tsx` (rule says inline small local types).
5. **Types location**: `type` / `interface` declarations added in a file under `utils/` (they belong in `models/`).
6. **Positional params**: a named function with two or more positional parameters.
7. **Generated files**: writing to a path matching `*.d.ts`, `migrations/`, or a file whose head contains `@generated` / `DO NOT EDIT`. This one should hard-block.

## Open decisions

- **Blocking or advisory?** Suggested: blocking for comments, the TS rules and generated files; advisory for the rest. Blocking means the hook exits non-zero so Claude must fix before continuing.
- **Scope**: this project's `.claude/settings.json`, or the global `~/.claude/settings.json` so it applies to every repo. The rules themselves are global (`~/.claude/programming.md`), which argues for global.
- **False positives on comments**: the check flags every comment, including legitimate ones (units, gotchas, constraints). Either accept the noise, or allow an opt-out marker on the line.

## Implementation sketch

- checker script, e.g. `~/.claude/scripts/check-programming-rules.mjs`, reads the file path from the hook payload on stdin, prints one line per violation, exits non-zero when a blocking rule is hit
- hook entries in `settings.json` under `hooks.PostToolUse` matching `Write|Edit`, with the script as the command
- the `update-config` skill knows the settings schema and can write both

## Related

- `~/.claude/programming.md` — the rules themselves
- memory `feedback_prewrite_rule_check.md` — the same problem recorded as a preference, which is necessary but demonstrably not sufficient
- memory `feedback_minimal_comments.md` — the most frequently broken rule
