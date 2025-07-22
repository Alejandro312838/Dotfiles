
#!/bin/bash
notify-send "Pomodoro" "⏸ Pausado"
sleep 0.5
pkill -SIGSTOP -f pomodoro.sh

