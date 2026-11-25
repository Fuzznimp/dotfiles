# Pull requests

Always write PR descriptions in this format, even when the repo has its own template:

```md
## AI;DR

- What changes and why, in plain words. As many bullets as needed.

Bali: <url of the related PR>

### Demo

## Details

- One bullet per concrete change (behaviour, API field, component).
- What was deliberately left out or kept as is.
```

- Related PRs (`Bali: <url>`, `App: <url>`, one per line) go after the bullets as plain lines, never as a bullet. Omit when there is none.
- `### Demo` sits inside AI;DR, left empty: the user fills it (screenshots, Storybook links). Include it when the PR changes something visible.
- Title: conventional commit. No AI attribution line.
- When updating an existing description, fetch the live body first and keep the user's edits.
