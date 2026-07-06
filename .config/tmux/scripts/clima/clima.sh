#!/usr/bin/env bash
# shellcheck disable=SC1091

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CWD/tmux.sh"
source "$CWD/icons.sh"
source "$CWD/.env"

# Weather data reference: http://openweathermap.org/weather-conditions

TTL=$((60 * 15)) # seconds
UNIT="metric"    # metric -> °C, m/s

# Beaufort scale label for a wind speed in m/s.
beaufort() {
  awk -v speed="$1" 'BEGIN {
    if (speed < 0.5)       print "calm";
    else if (speed < 1.6)  print "light air";
    else if (speed < 3.4)  print "light breeze";
    else if (speed < 5.5)  print "gentle breeze";
    else if (speed < 8.0)  print "moderate breeze";
    else if (speed < 10.8) print "fresh breeze";
    else if (speed < 13.9) print "strong breeze";
    else if (speed < 17.2) print "near gale";
    else if (speed < 20.8) print "gale";
    else if (speed < 24.5) print "strong gale";
    else if (speed < 28.5) print "storm";
    else if (speed < 32.7) print "violent storm";
    else                   print "hurricane";
  }'
}

clima() {
  NOW=$(date +%s)
  LAST_UPDATE_TIME=$(get_tmux_option @clima_last_update_time)
  MOD=$((NOW - LAST_UPDATE_TIME))
  SYMBOL=$(symbol "$UNIT")
  if [ -z "$LAST_UPDATE_TIME" ] || [ "$MOD" -ge "$TTL" ]; then
    LOCATION=$(curl --silent https://ifconfig.co/json)
    LAT=$(echo "$LOCATION" | jq -r .latitude)
    LON=$(echo "$LOCATION" | jq -r .longitude)
    if WEATHER=$(curl --silent --fail "https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&APPID=$OWM_API_KEY&units=$UNIT"); then
      ICON="$(icon "$(echo "$WEATHER" | jq .weather[0].id)")"
      TEMP="$(echo "$WEATHER" | jq .main.temp | cut -d . -f 1)$SYMBOL"
      FEELS_LIKE="$(echo "$WEATHER" | jq .main.feels_like | cut -d . -f 1)$SYMBOL"
      WIND_MS=$(echo "$WEATHER" | jq .wind.speed)
      WIND_KMH=$(awk -v speed="$WIND_MS" 'BEGIN { printf "%.0f", speed * 3.6 }')

      CLIMA="$ICON$TEMP ($FEELS_LIKE) ${WIND_KMH}km/h ($(beaufort "$WIND_MS"))"

      set_tmux_option "@clima_last_update_time" "$NOW"
      set_tmux_option "@clima_current_value" "$CLIMA"
    fi
  fi

  echo -n "$(get_tmux_option "@clima_current_value")"
}

clima
