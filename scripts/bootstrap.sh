#!/bin/bash

# bootstrap.sh
# Run once on a fresh Mac after cloning the dotfiles repo.

set -e

DOTFILES_PATH="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Starting bootstrap..."

# ─── Homebrew + packages ─────────────────────────────────────────────

"$DOTFILES_PATH/scripts/brew.sh"

# ─── Dotfiles symlinks ───────────────────────────────────────────────

echo "🔗 Stowing dotfiles..."
stow --no-folding . --target="$HOME/" --adopt
compaudit | xargs chmod g-w
echo "✅ Symlinks done."

# ─── Default shell ───────────────────────────────────────────────────

if [ "$SHELL" != "/bin/zsh" ]; then
  echo "🐚 Setting zsh as default shell..."
  chsh -s /bin/zsh
fi

# ─── macOS defaults ──────────────────────────────────────────────────

"$DOTFILES_PATH/scripts/osx.sh"

echo ""
echo "✅ Bootstrap complete. Restart your terminal."
