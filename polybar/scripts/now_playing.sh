#!/bin/bash

output=$(playerctl metadata --format '{{title}} - {{artist}}' 2>/dev/null)
if [ -z "$output" ]; then
  echo "Sin música"
else
  echo "$output"
fi

