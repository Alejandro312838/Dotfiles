#!/bin/bash

# Requiere: xdotool
active_window=$(xdotool getactivewindow getwindowname 2>/dev/null)

# Si no hay ventana activa, usar un valor por defecto
if [ -z "$active_window" ]; then
  echo "🪟 No window"
else
  echo "🪟 $active_window"
fi

