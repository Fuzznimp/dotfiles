#!/usr/bin/env bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CWD/tmux.sh"
source "$CWD/icons.sh"
source "$CWD/.env"

# Weather data reference: http://openweathermap.org/weather-conditions

TTL=$((60 * 15)) # seconds
UNIT="metric"    # metric -> °C, m/s
SHOW_ICON=1
SHOW_LOCATION=0
CLIMA_LOCATION="" # empty -> auto-detect via IP

get_location_coordinates() {
  local loc_response=""
  local lat=""
  local lon=""
  local city=""
  local country=""
  if [ -z "$1" ]; then
    loc_response=$(curl --silent https://ifconfig.co/json)
    lat=$(echo "$loc_response" | jq -r .latitude)
    lon=$(echo "$loc_response" | jq -r .longitude)
    city="$(echo "$loc_response" | jq -r .city)"
    country="$(echo "$loc_response" | jq -r .country_iso)"
  else
    loc_response=$(curl --silent --fail "https://api.openweathermap.org/geo/1.0/direct?q=$CLIMA_LOCATION&limit=1&appid=$OWM_API_KEY")
    lat=$(echo "$loc_response" | jq -r .[0].lat)
    lon=$(echo "$loc_response" | jq -r .[0].lon)
    city="$(echo "$loc_response" | jq -r .[0].name)"
    country="$(echo "$loc_response" | jq -r .[0].country)"
  fi

  echo -n "$(jq -n --arg "lat" "$lat" \
    --arg "lon" "$lon" \
    --arg "city" "$city" \
    --arg "country" "$country" \
    '{lat: $lat, lon: $lon, city: $city, country: $country}')"
}

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
  CLIMA_LAST_LOCATION=$(get_tmux_option @clima_last_location "")
  MOD=$((NOW - LAST_UPDATE_TIME))
  SYMBOL=$(symbol "$UNIT")
  if [ -z "$LAST_UPDATE_TIME" ] || [ "$MOD" -ge "$TTL" ] || [ "$CLIMA_LOCATION" != "$CLIMA_LAST_LOCATION" ]; then
    LOCATION=$(get_location_coordinates "$CLIMA_LOCATION")
    LAT=$(echo "$LOCATION" | jq -r .lat)
    LON=$(echo "$LOCATION" | jq -r .lon)
    WEATHER=$(curl --silent --fail "https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&APPID=$OWM_API_KEY&units=$UNIT")
    if [ "$?" -eq 0 ]; then
      CATEGORY=$(echo "$WEATHER" | jq .weather[0].id)
      TEMP="$(echo "$WEATHER" | jq .main.temp | cut -d . -f 1)$SYMBOL"
      ICON="$(icon "$CATEGORY")"
      CITY="$(echo "$LOCATION" | jq -r .city)"
      COUNTRY="$(echo "$LOCATION" | jq -r .country)"
      DESCRIPTION="$(echo "$WEATHER" | jq -r .weather[0].main)"
      FEELS_LIKE="$(echo "$WEATHER" | jq .main.feels_like | cut -d . -f 1)$SYMBOL"
      WIND_MS=$(echo "$WEATHER" | jq .wind.speed)
      WIND_KMH=$(awk -v speed="$WIND_MS" 'BEGIN { printf "%.0f", speed * 3.6 }')
      WIND_SPEED="${WIND_KMH}km/h ($(beaufort "$WIND_MS"))"
      CLIMA=""

      if [ "$SHOW_LOCATION" == 1 ]; then
        CLIMA="$CLIMA$CITY, "
      fi

      if [ "$SHOW_ICON" == 1 ]; then
        CLIMA="$CLIMA$ICON"
      fi

      CLIMA="$CLIMA$TEMP ($FEELS_LIKE) $WIND_SPEED"
      CLIMA_DETAILS="${CITY}, ${COUNTRY}: ${ICON} ${TEMP}, ${DESCRIPTION}, ${FEELS_LIKE}, ${WIND_SPEED}"

      set_tmux_option "@clima_last_update_time" "$NOW"
      set_tmux_option "@clima_current_value" "$CLIMA"
      set_tmux_option "@clima_details_value" "$CLIMA_DETAILS"
      set_tmux_option "@clima_last_location" "$CLIMA_LOCATION"
    fi
  fi

  echo -n "$(get_tmux_option "@clima_current_value")"
}

clima
