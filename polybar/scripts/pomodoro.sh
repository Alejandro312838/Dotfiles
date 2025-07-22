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
    FOCUS=1500       # 25 min
    BREAK=300        # 5 min
    LONG_BREAK=1200  # 20 min

    update_state() {
        echo "$1" > "$STATE_FILE"
    }

    countdown() {
        local seconds=$1
        while [ $seconds -gt 0 ]; do
            local min=$((seconds / 60))
            local sec=$((seconds % 60))
            printf -v timer "%02d:%02d" $min $sec
            update_state "$timer"
            sleep 1
            ((seconds--))
        done
    }

    for ((i = 0; i < CYCLES; i++)); do
        for ((j = 1; j <= ROUNDS; j++)); do
            notify-send "Pomodoro Started" "Focus time ($j/$ROUNDS)!"
            countdown "$FOCUS"

            if [[ $j -eq $ROUNDS ]]; then
                notify-send "Break Time" "Long break started"
                countdown "$LONG_BREAK"
            else
                notify-send "Break Time" "Short break started"
                countdown "$BREAK"
            fi
        done
    done

    update_state "✅ Done"
    sleep 600
    rm -f "$STATE_FILE"
) &

echo "▶ Start"

