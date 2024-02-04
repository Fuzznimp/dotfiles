#!/bin/bash

WORKSPACE_DIR="$HOME/workspace/sencrop"

while true; do
    PR_COUNT=$(gh pr list -S "user-review-requested:@me" | jq length)
    TOTAL_PR_COUNT=0

    for REPO_PATH in "$WORKSPACE_DIR"/*; do
        REPO_NAME=$(basename "$REPO_PATH")

        PR_COUNT=$(gh pr list --repo "sencrop/$REPO_NAME" --search "user-review-requested:@me" --state=open --json number | jq length)
        TOTAL_PR_COUNT=$((TOTAL_PR_COUNT + PR_COUNT))
    done

    if [ "$TOTAL_PR_COUNT" -gt 0 ]; then
        # Red color for >0 total pull requests
        COLOR="[bg=colour237,fg=colour167]"
    else
        # Green color for 0 total pull requests
        COLOR="[bg=green,fg=colour237]"
    fi

    echo -e "#$COLOR   $TOTAL_PR_COUNT"
    sleep 300  # Sleep for 5 minutes (300 seconds)
done
