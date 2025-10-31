#!/bin/bash

opcion=$(echo -e "Listar archivos\nCrear carpeta\nSalir" | rofi -dmenu -p "Elige una opción")

case "$opcion" in
"Listar archivos")
  ls -l | rofi -dmenu -p "Archivos:"
  ;;
"Crear carpeta")
  carpeta=$(rofi -dmenu -p "Nombre de la carpeta:")
  mkdir -p "$carpeta"
  notify-send "Carpeta creada" "$carpeta"
  ;;
"Salir")
  exit 0
  ;;
esac
