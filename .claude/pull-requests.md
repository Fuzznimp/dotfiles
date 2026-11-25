# Pull requests

Always write PR descriptions in this format, even when the repo has its own template:

```md
## AI;DR

- What changes and why, in plain words. As many bullets as needed.
- Related PRs on their own line: `Bali: <url>`, `App: <url>`.

### Demo

## Details

- One bullet per concrete change (behaviour, API field, component).
- What was deliberately left out or kept as is.
```

- `### Demo` sits inside AI;DR, left empty: the user fills it (screenshots, Storybook links). Include it when the PR changes something visible.
- Title: conventional commit. No AI attribution line.
- When updating an existing description, fetch the live body first and keep the user's edits.
