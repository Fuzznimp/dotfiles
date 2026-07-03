#!/bin/bash
# tmux status segment: count of open PRs across the sencrop org where I'm a
# requested reviewer. One org-wide search call (covers repos not cloned locally).

while true; do
  COUNT=$(gh search prs --review-requested=@me --state=open --owner=sencrop \
    --json number --jq 'length' 2>/dev/null)

    # Fall back to 0 if gh failed (offline / unauthed / non-numeric).
  [[ "$COUNT" =~ ^[0-9]+$ ]] || COUNT=0

  if [ "$COUNT" -gt 0 ]; then
    # Red color for >0 total pull requests
    COLOR="[bg=colour237,fg=colour167]"
  else
    # Green color for 0 total pull requests
    COLOR="[bg=colour237,fg=green]"
  fi

  echo -e "#$COLOR   $COUNT "

  sleep 300
done
