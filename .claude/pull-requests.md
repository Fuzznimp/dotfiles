# Pull requests

Always write PR descriptions in this format, even when the repo has its own template:

```md
## AI;DR

- What changes and why, in plain words. As many bullets as needed.

Figma: <url of the design frame>
Ticket: <url of the ticket>
Bali: <url of the related PR>

### Demo

## Details

<free-form, written for an AI reviewer>
```

AI;DR is for humans: short, plain words. Details is read by an AI (reviewer, future agent): make it as useful as possible for that reader, in whatever shape fits (prose, sub-headings, tables, code blocks, bullets). Aim for what lets it review or continue the work without re-deriving anything:

- Context and the problem being solved.
- The rules and decisions, with their rationale (why this approach, which alternatives were dropped).
- Contracts: API fields and their values, types, i18n keys, flags, with file paths.
- Edge cases and how they are handled.
- Compatibility and rollout constraints (breaking changes, force update, deploy order across repos).
- What was deliberately left out, kept as is, or diverges from the design, and why.
- How it was verified (tests, commands, manual checks).

- Link lines go after the bullets as plain lines, never as bullets, one per line, in this order: `Figma: <url>` (the design frame the work implements), `Ticket: <url>` (Notion, Linear…), then related PRs (`Bali: <url>`, `App: <url>`, `UI: <url>`). Include each only when it applies: a URL you were given or found in the session, never a guessed one. Omit a line with no URL.
- `### Demo` sits inside AI;DR, left empty: the user fills it (screenshots, Storybook links). Include it when the PR changes something visible.
- Title: conventional commit. No AI attribution line.
- When updating an existing description, fetch the live body first and keep the user's edits.
