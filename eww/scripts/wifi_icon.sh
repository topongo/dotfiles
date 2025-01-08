#!/bin/bash

next_signal_check=0
last_icon=""

while true; do
  if nmcli r wifi | grep -q enabled; then
    if nmcli -t d status | grep wifi | cut -d ':' -f 3 | grep -wq connected; then
      if [ "$next_signal_check" -lt $(date +%s) ]; then
        signal="$(nmcli -t -f IN-USE,SIGNAL d wifi list | grep \* | cut -d ':' -f 2 )"
        if [ "$signal" -gt 80 ]; then
          ico="󰤨"
        elif [ "$signal" -gt 60 ]; then
          ico="󰤥"
        elif [ "$signal" -gt 40 ]; then
          ico="󰤢"
        elif [ "$signal" -gt 20 ]; then
          ico="󰤟"
        else
          ico="󰤯"
        fi
        next_signal_check=$(( $(date +%s) + 60 ))
      fi
      echo "$ico"
    else
      echo "󰤫"
    fi
  else
    echo "󰤮"
  fi
  sleep 1
done

  
