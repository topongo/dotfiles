#!/bin/bash

function draw () {
  ACTIVE=$(hyprctl monitors -j | jq -r '.[0].activeWorkspace.id')
  hyprctl workspaces -j | jq -rc "map({\"index\": .id, \"name\": .id, \"selected\": ($ACTIVE == .id)}) | sort_by(.index)"
}

draw

socat \
  -u UNIX:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | \
  while read p; do
    if echo $p | grep -qE '(|create|destroy)workspace'; then
      draw "$p"
    fi
  done
