#!/bin/sh

# Ensure this is a directory
[ -L ~/.config/eww ] && exit 1
[ -d ~/.config/eww ] || mkdir -p ~/.config/eww

