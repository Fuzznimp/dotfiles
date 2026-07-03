#!/bin/bash

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "🍺 Checking Homebrew..."

if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed."
fi

echo "📋 Installing from Brewfile..."
brew bundle --file="$REPO_ROOT/Brewfile"

echo "🔌 Installing gh-dash extension..."
gh extension install dlvhdr/gh-dash 2>/dev/null || echo "  gh-dash already installed, skipping."

echo "✅ Brew setup done."
