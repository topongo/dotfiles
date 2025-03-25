#!/bin/zsh

[ -z "$1" ] && color="#010f14" || color=$1

(
  echo "[color]"
  echo "background = $color" 
) > ~/.config/polybar/background.ini

