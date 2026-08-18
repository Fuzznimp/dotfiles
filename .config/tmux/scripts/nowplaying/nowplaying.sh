#!/usr/bin/env bash
# tmux status segment: currently-playing macOS media, via the Swift helper.
# Long titles scroll as a marquee, one frame per status-interval tick.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

maxWidthInChars=40
scrollStepInChars=4
holdTicks=2
cacheTtlInSeconds=3
cacheFile="${TMPDIR:-/tmp}/tmux-nowplaying.cache"

command -v swift >/dev/null 2>&1 || exit 0

# tmux may run status commands with no locale, which makes ${#var} and substring
# expansion count bytes and slice a multibyte title mid-character.
[ -n "${LC_ALL}${LC_CTYPE}${LANG}" ] || export LC_ALL="en_US.UTF-8"

now="$(date +%s)"

# The helper costs ~0.25s per run, too much to pay on every tick when only the
# scroll offset changes between them.
cacheAgeInSeconds=$((cacheTtlInSeconds + 1))
[ -f "$cacheFile" ] && cacheAgeInSeconds=$((now - $(stat -f %m "$cacheFile")))

if [ "$cacheAgeInSeconds" -ge "$cacheTtlInSeconds" ]; then
  if "$SCRIPT_DIR/nowplaying_mediaremote.swift" >"$cacheFile.$$" 2>/dev/null; then
    mv -f "$cacheFile.$$" "$cacheFile"
  else
    rm -f "$cacheFile.$$"
  fi
fi

title="$(cat "$cacheFile" 2>/dev/null)"
[ -n "$title" ] || exit 0

titleLength=${#title}

if [ "$titleLength" -le "$maxWidthInChars" ]; then
  window="$title"
else
  maxOffset=$((titleLength - maxWidthInChars))
  scrollTicks=$(((maxOffset + scrollStepInChars - 1) / scrollStepInChars))
  tick=$((now % (holdTicks + scrollTicks + holdTicks)))

  if [ "$tick" -lt "$holdTicks" ]; then
    offset=0
  elif [ "$tick" -lt $((holdTicks + scrollTicks)) ]; then
    offset=$(((tick - holdTicks + 1) * scrollStepInChars))
    [ "$offset" -gt "$maxOffset" ] && offset=$maxOffset
  else
    offset=$maxOffset
  fi

  window="${title:offset:maxWidthInChars}"
fi

# A bare `#` in a title would start a tmux format sequence.
echo "♪ ${window//#/##}"
