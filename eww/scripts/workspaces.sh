#!/bin/bash

BUTTON_TEMP="$(head -n 1 templates/workspaces.button.yuck | tr -d '\n')"
BOX_TEMP="$(head -n 1 templates/workspaces.box.yuck | tr -d '\n')"

function redraw() {
  printf "$BOX_TEMP" "$(
    SEL=$(hyprctl monitors -j | jq -r '.[0].activeWorkspace.id')
    hyprctl workspaces -j | jq -r '.[].name' | sort | while read p; do
      if [ "$p" == "$SEL" ]; then
        printf "$BUTTON_TEMP" " wselected" "$p" "$p" 
      else
        printf "$BUTTON_TEMP" "" "$p" "$p"
      fi
    done
  )"
  echo
}

redraw

socat -u UNIX:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read p; do
  if echo $p | grep -qE "(|create|destroy)workspace"; then
    redraw
  fi
done

echo Exited normally $(date) >> /tmp/workspaces.log
 
