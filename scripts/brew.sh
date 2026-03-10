#!/bin/bash

set -e

echo "🍺 Checking Homebrew..."

if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed."
fi

echo "📋 Installing from Brewfile..."
brew bundle --file="$(dirname "$0")/Brewfile"

echo "🔌 Installing gh-dash extension..."
gh extension install dlvhdr/gh-dash 2>/dev/null || echo "  gh-dash already installed, skipping."

echo "✅ Brew setup done."
