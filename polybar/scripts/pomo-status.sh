#!/bin/bash

STATE_FILE="/tmp/polybar-pomodoro.state"

# Si no existe el archivo, sal sin error ni salida
[[ ! -f "$STATE_FILE" ]] && exit 0

# Leer contenido del archivo
content=$(<"$STATE_FILE")

# Mostrar "Paused" si está vacío, o el contenido si tiene algo
if [[ -n "$content" ]]; then
    echo "$content"
else
    echo "⏸ Paused"
fi

