#!/bin/bash
# tmux status segment: online/offline indicator (macOS).

if ping -c 1 -t 3 1.1.1.1 >/dev/null 2>&1; then
  echo "✅ "
else
  echo "⛔️ "
fi
