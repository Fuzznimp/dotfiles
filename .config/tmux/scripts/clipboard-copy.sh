#!/bin/bash

# tmux copy-mode target: reads selection on stdin, puts it on the system clipboard.
# Probed in order so macOS, WSL, and plain Linux all work from one bind.
#   clip.exe: WSL interop, needs CRLF and mangles UTF-8 unless piped through iconv.

set -e

for bin in pbcopy wl-copy xclip clip.exe; do
  command -v "$bin" >/dev/null 2>&1 || continue

  case "$bin" in
    xclip) exec xclip -selection clipboard ;;
    clip.exe) iconv -f utf-8 -t utf-16le | clip.exe; exit ;;
    *) exec "$bin" ;;
  esac
done

# No clipboard tool: drain stdin so copy-pipe does not see a broken pipe.
cat >/dev/null
