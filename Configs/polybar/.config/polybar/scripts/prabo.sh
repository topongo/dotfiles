#!/usr/bin/env zsh

if ping -c 1 -w 4 -W 4 prabo.org > /dev/null 2>&1; then
  echo 󰣺
else
  echo 󰣼
fi

