#!/usr/bin/env bash
# Battery info for Eww
set -euo pipefail

# Pick the first BAT* directory (BAT0, BAT1, …)
BAT_DIR="/sys/class/power_supply/$(ls /sys/class/power_supply | grep -m1 "^BAT")"

if [[ -d "$BAT_DIR" ]]; then
    CAPACITY=$(<"$BAT_DIR/capacity")
    STATUS=$(<"$BAT_DIR/status")
    if [[ "$STATUS" == "Charging" ]]; then
        CHARGING=true
    else
        CHARGING=false
    fi

    ICON="󰂎"
    if [[ "$CHARGING" == "true" ]]; then
        ICON="󰂄"
    elif (( CAPACITY >= 95 )); then
        ICON="󰁹"
    elif (( CAPACITY >= 85 )); then
        ICON="󰂂"
    elif (( CAPACITY >= 75 )); then
        ICON="󰂁"
    elif (( CAPACITY >= 65 )); then
        ICON="󰂀"
    elif (( CAPACITY >= 55 )); then
        ICON="󰁿"
    elif (( CAPACITY >= 45 )); then
        ICON="󰁾"
    elif (( CAPACITY >= 35 )); then
        ICON="󰁽"
    elif (( CAPACITY >= 25 )); then
        ICON="󰁼"
    elif (( CAPACITY >= 15 )); then
        ICON="󰁻"
    elif (( CAPACITY >= 5 )); then
        ICON="󰁺"
    else
        ICON="󰂎"
    fi

    printf '{"percentage":%s,"status":"%s","charging":%s,"icon":"%s"}\n' \
           "$CAPACITY" "$STATUS" "$CHARGING" "$ICON"
else
    # Desktop with no battery
    echo '{"percentage":100,"status":"Unknown","charging":false,"icon":"󰁹"}'
fi

