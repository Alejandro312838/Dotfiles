#!/bin/bash

PRIMARY="DP-1"  # Pantalla de la laptop
EXTERNAL=$(xrandr | grep ' connected' | grep -v "$PRIMARY" | awk '{print $1}')

# Verifica si hay monitor externo
if [ -z "$EXTERNAL" ]; then
  notify-send "❌ Mirror fallido" "No hay monitor externo conectado."
  exit 1
fi

# Obtiene resoluciones de cada monitor
res_primary=$(xrandr | grep -A10 "^$PRIMARY" | grep -oP '^\s+\K\d+x\d+')
res_external=$(xrandr | grep -A10 "^$EXTERNAL" | grep -oP '^\s+\K\d+x\d+')

# Busca resoluciones comunes
common_res=$(comm -12 <(echo "$res_primary" | sort) <(echo "$res_external" | sort) | tail -n 1)

if [ -z "$common_res" ]; then
  notify-send "❌ Mirror fallido" "No hay resolución común entre $PRIMARY y $EXTERNAL."
  exit 1
fi

# Aplica la configuración de duplicado
xrandr \
  --output "$PRIMARY" --mode "$common_res" \
  --output "$EXTERNAL" --mode "$common_res" --same-as "$PRIMARY"

notify-send "✅ Pantallas duplicadas" "Resolución: $common_res"

