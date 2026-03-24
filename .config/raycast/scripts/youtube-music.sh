#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title YouTube Music
# @raycast.mode silent
# @raycast.packageName Custom

TAB=$(curl -s http://localhost:4625/list_tabs | jq -r '.[] | select(.url | contains("music.youtube.com")) | .id' | head -1)

if [ -n "$TAB" ]; then
  ID=$(echo "$TAB" | cut -d. -f2)
  curl -s "http://localhost:4625/activate_tab/$ID"
else
  curl -s "http://localhost:4625/open_url?url=https://music.youtube.com"
fi

open -a "Zen"
