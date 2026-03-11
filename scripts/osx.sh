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

# ─── Keyboard ────────────────────────────────────────────────────────

# Caps Lock → Control (built-in MacBook Pro keyboard)
# ID is hardware-specific. To find yours: defaults -currentHost read -g | grep modifiermapping
defaults -currentHost write -g "com.apple.keyboard.modifiermapping.1452-834-0" -array \
  '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771300</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer></dict>'

# ─── Keyboard Shortcuts ───────────────────────────────────────────────
# Disable shortcuts that conflict with custom tools (Raycast, etc.)

# Screenshot shortcuts (15-19) — disabled (using other tools)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 15 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 16 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 17 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 18 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 19 '<dict><key>enabled</key><false/></dict>'

# Mission Control & Spaces (20-26) — disabled
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 20 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 21 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 22 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 23 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 24 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 25 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 26 '<dict><key>enabled</key><false/></dict>'

# Window tiling (28-31) — disabled
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 28 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>51</integer><integer>20</integer><integer>1179648</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 29 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>51</integer><integer>20</integer><integer>1441792</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>52</integer><integer>21</integer><integer>1179648</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 31 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>52</integer><integer>21</integer><integer>1441792</integer></array><key>type</key><string>standard</string></dict></dict>'

# Cmd+` cycle windows — disabled
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 59 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>96</integer><integer>9437184</integer></array><key>type</key><string>standard</string></dict></dict>'

# Input source switching (60-61) — disabled
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>786432</integer></array><key>type</key><string>standard</string></dict></dict>'

# Spotlight (64-65) — disabled (using Raycast or similar)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>'

# Siri (162) — disabled
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 162 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>96</integer><integer>9961472</integer></array><key>type</key><string>standard</string></dict></dict>'

# Dictation (164) — disabled
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 164 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>65535</integer><integer>0</integer></array><key>type</key><string>standard</string></dict></dict>'

# ─── Apply ───────────────────────────────────────────────────────────

killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
# Apply keyboard shortcut changes without requiring a logout
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u 2>/dev/null || true

echo "✅ Done. Some changes may require a logout to take effect."
