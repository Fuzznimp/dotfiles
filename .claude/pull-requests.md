# Pull requests

Always write PR descriptions in this format, even when the repo has its own template:

```md
## AI;DR

### Content

- What changes and why, in plain words. As many bullets as needed.

### Context

Figma: <url of the design frame>
Ticket: <url of the ticket>

### Related PRs

Bali: <url>
UI: <url>

### Demo

---

## Details for 🤖

<free-form, written for an AI reviewer>
```

AI;DR is for humans: short, plain words. "Details for 🤖" is read by an AI (reviewer, future agent): make it as useful as possible for that reader, in whatever shape fits (prose, sub-headings, tables, code blocks, bullets). Aim for what lets it review or continue the work without re-deriving anything:

- Context and the problem being solved.
- The rules and decisions, with their rationale (why this approach, which alternatives were dropped).
- Contracts: API fields and their values, types, i18n keys, flags, with file paths.
- Edge cases and how they are handled.
- Compatibility and rollout constraints (breaking changes, force update, deploy order across repos).
- What was deliberately left out, kept as is, or diverges from the design, and why.
- How it was verified (tests, commands, manual checks).

## Rules

- Links are plain lines, never bullets, one per line. `### Context`: `Figma: <url>` (the design frame the work implements), `Ticket: <url>` (Notion, Linear…). `### Related PRs`: one line per other repo (`Bali: <url>`, `App: <url>`, `UI: <url>`). Include a link only when it applies: a URL you were given or found in the session, never a guessed one. Drop a sub-section with no link.
- `### Demo` is left empty: the user fills it (screenshots, Storybook links). Include it when the PR changes something visible.
- `---` (blank line above and below) separates the human part from "Details for 🤖".
- Title: conventional commit. No AI attribution line.
- When updating an existing description, fetch the live body first and keep the user's edits.
