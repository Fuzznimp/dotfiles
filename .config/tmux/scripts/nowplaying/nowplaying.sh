#!/usr/bin/env bash
# tmux status segment: currently-playing macOS media, via the Swift helper.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

output="$("$SCRIPT_DIR/nowplaying_mediaremote.swift" 2>/dev/null)"

if [ -n "$output" ]; then
  echo "♪ $output"
fi
