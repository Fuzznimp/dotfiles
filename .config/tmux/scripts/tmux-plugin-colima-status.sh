#!/bin/bash

while true; do
    if colima status >/dev/null 2>&1; then
        COLOR="[bg=colour237,fg=green]"
    else
        COLOR="[bg=colour237,fg=colour167]"
    fi

    echo -e "#$COLOR 󰡨 #[bg=colour237,fg=colour239]"

    sleep 3600
done
