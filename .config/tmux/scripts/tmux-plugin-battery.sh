#!/bin/bash
# tmux status segment: battery icon + percentage (macOS).
# Self-contained replacement for tmux-battery -> no upstream breaking changes.
# Prints once and exits; tmux re-runs it every status-interval.

raw="$(pmset -g batt)"

# No battery (desktop Mac) -> render nothing.
echo "$raw" | grep -q "InternalBattery" || exit 0

percentage="$(echo "$raw" | grep -Eo '[0-9]+%' | head -1 | tr -d '%')"
[[ "$percentage" =~ ^[0-9]+$ ]] || percentage=0

# State: charging / charged / discharging.
if echo "$raw" | grep -q "AC Power"; then
  if [ "$percentage" -ge 100 ] || echo "$raw" | grep -qi "charged"; then
    state="charged"
  else
    state="charging"
  fi
else
  state="discharging"
fi

# Icon: charging bolt, else fill tier by 10% steps (nerd font, material design).
if [ "$state" = "charging" ]; then
    icon="󰂄"
elif [ "$percentage" -ge 95 ]; then icon="󰁹"
elif [ "$percentage" -ge 85 ]; then icon="󰂂"
elif [ "$percentage" -ge 75 ]; then icon="󰂁"
elif [ "$percentage" -ge 65 ]; then icon="󰂀"
elif [ "$percentage" -ge 55 ]; then icon="󰁿"
elif [ "$percentage" -ge 45 ]; then icon="󰁾"
elif [ "$percentage" -ge 35 ]; then icon="󰁽"
elif [ "$percentage" -ge 25 ]; then icon="󰁼"
elif [ "$percentage" -ge 15 ]; then icon="󰁻"
else icon="󰁺"; fi

# Color: red when low and unplugged, green when charged/charging, else default.
if [ "$state" = "discharging" ] && [ "$percentage" -le 20 ]; then
  color="colour167"
elif [ "$state" != "discharging" ]; then
  color="green"
else
  color="colour246"
fi

echo -e "#[fg=$color] $icon $percentage% #[fg=colour246]"
