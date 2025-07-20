#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT*/capacity)
status=$(cat /sys/class/power_supply/BAT*/status)

if [ "$status" = "Charging" ]; then
    icon=""
elif [ "$capacity" -ge 80 ]; then
    icon=""
elif [ "$capacity" -ge 60 ]; then
    icon=""
elif [ "$capacity" -ge 40 ]; then
    icon=""
elif [ "$capacity" -ge 20 ]; then
    icon=""
else
    icon=""
fi

echo "$icon $capacity%"

