#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Run Applications as Root

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt='Applications'
mesg='Run Applications as Root'

if [[ "$theme" == *'type-1'* ]]; then
  list_col='1'
  list_row='5'
  win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
  list_col='1'
  list_row='5'
  win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
  list_col='1'
  list_row='5'
  win_width='520px'
elif [[ ("$theme" == *'type-2'*) || ("$theme" == *'type-4'*) ]]; then
  list_col='5'
  list_row='1'
  win_width='670px'
fi

# Options
layout=$(cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2)
if [[ "$layout" == 'NO' ]]; then
  option_1=" Catppucchin"
  option_2=" Kanagawa"
  option_3=" Geany"
  option_4=" Ranger"
  option_5=" Vim"
else
  option_1=""
  option_2=""
  option_3=""
  option_4=""
  option_5=""
fi

# Rofi CMD
rofi_cmd() {
  rofi -theme-str "window {width: $win_width;}" \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Ejecutar comando
run_cmd() {
  local polkit_cmd="pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY"
  case "$1" in
  --opt1)
    origen_dir="$HOME/scripts/catppuccin/"
    destino_dir="$HOME/scripts/"
    cp -rf "${origen_dir}"* "${destino_dir}"

    sed -i 's/colorscheme = ".*"/colorscheme = "catppuccin-mocha"/' \
      "$HOME/.config/nvim/lua/plugins/colorscheme.lua"

    i3-msg reload
    i3-msg restart
    ;;
  --opt2)
    origen_dir="$HOME/scripts/kanagawa/"
    destino_dir="$HOME/scripts/"
    cp -rf "${origen_dir}"* "${destino_dir}"

    sed -i 's/colorscheme = ".*"/colorscheme = "kanagawa-dragon"/' \
      "$HOME/.config/nvim/lua/plugins/colorscheme.lua"

    i3-msg reload
    i3-msg restart
    ;;
  --opt3)
    $polkit_cmd geany &
    ;;
  --opt4)
    $polkit_cmd alacritty -e ranger &
    ;;
  --opt5)
    $polkit_cmd alacritty -e vim &
    ;;
  esac
}

# Acciones
chosen="$(run_rofi)"

case "$chosen" in
"$option_1") run_cmd --opt1 ;;
"$option_2") run_cmd --opt2 ;;
"$option_3") run_cmd --opt3 ;;
"$option_4") run_cmd --opt4 ;;
"$option_5") run_cmd --opt5 ;;
esac
