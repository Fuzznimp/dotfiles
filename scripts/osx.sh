#!/bin/bash

# macOS defaults
# Run once after a fresh install to restore system preferences.

set -e

echo "🍎 Applying macOS defaults..."

# ─── Dock ────────────────────────────────────────────────────────────

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 33

# ─── Finder ──────────────────────────────────────────────────────────

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# ─── Screenshots ─────────────────────────────────────────────────────

defaults write com.apple.screencapture location -string "$HOME/Documents"
defaults write com.apple.screencapture type -string "png"

# ─── Apply ───────────────────────────────────────────────────────────

killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true

echo "✅ Done. Some changes may require a logout to take effect."
