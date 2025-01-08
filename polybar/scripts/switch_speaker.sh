#!/bin/zsh

default_sink=$(pactl get-default-sink)
nextok=
first=

pactl list sinks | grep node.name | sed -E 's/.*node\.name = \"(.*)\"/\1/' | while read device; do
  if [[ -z $first ]]; then
    first=$device
  fi
  if ! [[ -z $nextok ]]; then
    pactl set-default-sink $device
    exit
  elif [[ $device = $default_sink ]]; then
    nextok=1
  fi
done

pactl set-default-sink $first

