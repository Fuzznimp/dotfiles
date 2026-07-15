#!/usr/bin/env bash

symbol() {
  case $1 in
    metric)
      echo '℃'
      ;;
    imperial)
      echo '℉'
      ;;
    kelvin)
      echo ' K'
      ;;
    *)
      echo '℃'
      ;;
  esac
}

icon() {
  case $1 in
    # Thunderstorm group
    200 | 201 | 202 | 210 | 211 | 212 | 221 | 230 | 231 | 232)
      echo ' '
      ;;
    # Drizzle group
    300 | 301 | 302 | 310 | 311 | 312 | 313 | 314 | 321)
      echo ' '
      ;;
    # Rain group
    500 | 501 | 502 | 503 | 504)
      echo ' '
      ;;
    511)
      echo ' '
      ;;
    520 | 521 | 522 | 531)
      echo ' '
      ;;
    # Snow group
    600 | 601 | 602)
      echo ' '
      ;;
    611 | 612 | 613 | 615 | 616 | 620 | 621 | 622)
      echo ' '
      ;;
    # Atmosphere group
    701 | 711 | 721 | 731 | 751 | 761 | 762 | 771)
      echo ' '
      ;;
    741)
      echo ' '
      ;;
    781)
      echo ' '
      ;;
    # Clear group
    800)
      echo ' '
      ;;
    # Clouds group
    801)
      echo ' '
      ;;
    802 | 804)
      echo ' '
      ;;
    803)
      echo ' '
      ;;
    *)
      echo "$1"
      ;;
  esac
}
