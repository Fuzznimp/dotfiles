#!/usr/bin/env bash
# Open a GitHub PR in the browser, prefilled with:
#   - title = first (oldest) commit subject on this branch -> follows commit convention
#   - body  = fixed template (## Overview / ## Demo)
# Called from lazygit (cwd = current repo).

set -e

# Repo default branch (e.g. main/master).
base="$(gh repo view --json defaultBranchRef -q .defaultBranchRef.name)"

# First commit subject since base (oldest first).
title="$(git log --reverse --format='%s' "origin/${base}..HEAD" | head -1)"

body='## Overview

## Demo
'

gh pr create --web --title "$title" --body "$body"
