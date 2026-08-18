#!/bin/bash

# No colima (Linux/WSL runs dockerd natively) -> render nothing rather than a
# permanently red icon.
command -v colima >/dev/null 2>&1 || exit 0

while true; do
  if colima status >/dev/null 2>&1; then
    COLOR="[bg=colour237,fg=green]"
  else
    COLOR="[bg=colour237,fg=colour167]"
  fi

  echo -e "#${COLOR}󰡨 #[bg=colour237,fg=colour239]"

  sleep 300
done
