#!/bin/bash
rm -f /tmp/polybar-pomodoro.state && notify-send "You left pomodoro ):"
polybar-msg action "#polybar-pomodoro.hook.0"
killall polybar
polybar main &

