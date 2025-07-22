#!/bin/bash

# DEFAULT VALUES
ICON="xclock"
NAME="Simple Pomodoro"

FOCUS=1200
BREAK=300
LONG_BREAK=1800
ROUNDS=4
CYCLES=2

FOCUS_SCRIPT=""
BREAK_SCRIPT=""
LBREAK_SCRIPT=""
PAUSE_SCRIPT=""
RESUME_SCRIPT=""

HELP="Simple Pomodoro Timer!
Options:
\t-f <focus time in sec>
\t-b <break time in sec>
\t-l <long break in sec>
\t-r <number of sessions before long break>
\t-c <number of cycles>
\t-F <command to run when focus time starts>
\t-B <command to run when short break starts>
\t-L <command to run when long break starts>
\t-P <command to run when paused>
\t-R <command to run when resumed>"

# PARSE OPTIONS
while getopts "f:b:r:c:l:F:B:L:P:R:h" opt; do
	case $opt in
		f) FOCUS=$OPTARG ;;
		b) BREAK=$OPTARG ;;
		r) ROUNDS=$OPTARG ;;
		c) CYCLES=$OPTARG ;;
		l) LONG_BREAK=$OPTARG ;;
		F) FOCUS_SCRIPT=$OPTARG ;;
		B) BREAK_SCRIPT=$OPTARG ;;
		L) LBREAK_SCRIPT=$OPTARG ;;
		P) PAUSE_SCRIPT=$OPTARG ;;
		R) RESUME_SCRIPT=$OPTARG ;;
		h|\?) printf "$HELP\n"; exit 1 ;;
	esac
done

# Flags
paused=false

# Functions
pause() {
	paused=true
	notify-send -a "$NAME" "⏸️ Pomodoro Paused" -i "$ICON"
	sh -c "$PAUSE_SCRIPT"
}

resume() {
	paused=false
	notify-send -a "$NAME" "▶️ Pomodoro Resumed" -i "$ICON"
	sh -c "$RESUME_SCRIPT"
}

# Modified sleep function to support pause/resume

STATE_FILE="/tmp/polybar-pomodoro.state"

write_state() {
    local label="$1"
    local seconds_left="$2"
    local minutes=$((seconds_left / 60))
    local seconds=$((seconds_left % 60))
    printf "%s %02d:%02d\n" "$label" "$minutes" "$seconds" > "$STATE_FILE"
}

timer_sleep() {
    local duration=$1
    local label=$2
    local remaining=$duration
    while [[ $remaining -gt 0 ]]; do
        if $paused; then
            sleep 1
            continue
        fi
        write_state "$label" "$remaining"
        sleep 1
        ((remaining--))
    done
}

start() {
	notify-send -a "$NAME" "🍅 Pomodoro Session Started!" -i "$ICON"
	sh -c "$FOCUS_SCRIPT"
	timer_sleep $FOCUS "Work"

	if [[ $3 -eq 1 ]]; then
		notify-send -a "$NAME" "🧘 LONG BREAK TIME!" -i "$ICON"
		sh -c "$LBREAK_SCRIPT"
		timer_sleep $LONG_BREAK "Long Break"
	elif [[ $3 -eq 2 ]]; then
		return
	else
		notify-send -a "$NAME" "☕ SHORT BREAK TIME!" -i "$ICON"
		sh -c "$BREAK_SCRIPT"
		timer_sleep $BREAK "Break"
	fi
}
quit() {
	sh -c "$EXIT_SCRIPT"
	exit 0
}

trap quit SIGINT

for (( i=0; i<$CYCLES; i++ ))
do
	for (( j=1; j<=$ROUNDS; j++ ))
	do
		k=$((i + 1))
		if [[ $j -eq $ROUNDS ]] && [[ $i -ne $((CYCLES - 1)) ]]; then
			start $k $j 1
		elif [[ $j -eq $ROUNDS ]] && [[ $i -eq $((CYCLES - 1)) ]]; then
			start $k $j 2
		else
			start $k $j 0
		fi
	done
done
quit

