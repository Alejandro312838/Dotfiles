#!/bin/bash

STATE_FILE="/tmp/polybar-pomodoro.state"

# Mostrar estado si ya está corriendo
if [[ -f "$STATE_FILE" ]]; then
    cat "$STATE_FILE"
    exit 0
fi

# INICIA el pomodoro en segundo plano
(
    CYCLES=1
    ROUNDS=4
    FOCUS=1500
    BREAK=300
    LONG_BREAK=1200

    update_state() {
        echo "$1" > "$STATE_FILE"
    }

    for ((i = 0; i < CYCLES; i++)); do
        for ((j = 1; j <= ROUNDS; j++)); do
            update_state "🍅 Focus ($j/$ROUNDS)"
            notify-send "Pomodoro Started" "Focus time!"
            sleep "$FOCUS"

            if [[ $j -eq $ROUNDS ]]; then
                update_state "🛌 Long Break"
                notify-send "Break Time" "Long break started"
                sleep "$LONG_BREAK"
            else
                update_state "☕ Break"
                notify-send "Break Time" "Short break started"
                sleep "$BREAK"
            fi
        done
    done

    update_state "✅ Done"
    sleep 600
    rm -f "$STATE_FILE"
) &

echo "▶ Start"

