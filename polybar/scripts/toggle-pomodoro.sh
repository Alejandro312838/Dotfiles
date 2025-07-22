#!/bin/bash

POMODORO_PID=$(pgrep -f pomodoro.sh)

if [[ -z "$POMODORO_PID" ]]; then
    notify-send "Pomodoro" "No running pomodoro session"
    exit 1
fi

if [[ -f /tmp/pomodoro-paused ]]; then
    notify-send "▶️ Pomodoro Resumed"
    rm /tmp/pomodoro-paused
    kill -CONT "$POMODORO_PID"
else
    notify-send "⏸️ Pomodoro Paused"
    touch /tmp/pomodoro-paused
    # Da un breve tiempo para mostrar la notificación antes de congelar el proceso
    (sleep 0.5 && kill -STOP "$POMODORO_PID") &
fi

