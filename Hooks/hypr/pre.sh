#!/bin/sh

# Ensure this is a directory
[ -L ~/.config/hypr ] && exit 1
[ -d ~/.config/hypr ] || mkdir -p ~/.config/hypr

cd ~/.config/dotfiles

# Ensure the `private.conf` file exists
if ! [ -f Configs/hypr/.config/hypr/private.conf ]; then
  echo "no such file: \`Configs/hypr/.configs/hypr/private.conf\`"
  exit 1
fi
