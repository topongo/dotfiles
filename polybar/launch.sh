#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

cd $DIR

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


if [ -e /sys/class/power_supply/BAT0 ]; then 
  LOCAL=laptop.ini
else 
  LOCAL=desktop.ini
fi

# Temporarily merge configs
cat "$DIR/config.ini" "$DIR/$LOCAL" > /tmp/polybar.ini

export PATH="$HOME/.cargo/bin:$PATH"

# Launch the bar
polybar -q main --reload -c /tmp/polybar.ini &
