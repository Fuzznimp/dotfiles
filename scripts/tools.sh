#!/bin/bash

# tools.sh
# Clone and build the Go TUI tools that tmux.conf and the zsh aliases point at.
# Idempotent: existing checkouts are pulled, then rebuilt.

set -e

SCRIPTS_PATH="$HOME/workspace/scripts"

# Each repo builds to a binary named after the repo, gitignored inside it.
REPOS=(
  tmux-pane-manager
  tmux-yoink
  tmux-gh-prs
  tmux-weather
  git-commit-wizard
)

echo "🔧 Setting up Go tools..."

if ! command -v go &>/dev/null; then
  echo "❌ go not found. Run brew.sh first."
  exit 1
fi

mkdir -p "$SCRIPTS_PATH"

for repo in "${REPOS[@]}"; do
  dir="$SCRIPTS_PATH/$repo"

  if [ -d "$dir/.git" ]; then
    echo "  ⬇️  $repo: pulling..."
    # Local edits or a diverged branch must not abort the whole bootstrap.
    git -C "$dir" pull --ff-only || echo "     skipped pull, working tree not clean or diverged."
  else
    echo "  📦 $repo: cloning..."
    # gh honors the configured ssh protocol so pushes work; https keeps a
    # fresh Mac with no uploaded key from hard-failing.
    if command -v gh &>/dev/null && gh auth status &>/dev/null; then
      gh repo clone "Fuzznimp/$repo" "$dir"
    else
      git clone "https://github.com/Fuzznimp/$repo.git" "$dir"
    fi
  fi

  echo "  🔨 $repo: building..."
  (cd "$dir" && go build -o "$repo" .)
done

echo "✅ Go tools done."
