#!/bin/zsh

HERE=$(dirname "$0")
HERE=$(cd "$HERE" && pwd)

if ! [ -d ~/.config ]; then
  mkdir ~/.config
fi

cd ~/.config


if [[ ! -L ~/de ]]; then
	ln -fs $HERE ~/de
fi

while read l; do
  split=(${(s/ /)l})
  if ! [[ -z ${split[2]} ]]; then
    mkdir -p $(basename ${split[2]})
  fi
  ln -vfs ~/de/${split[1]} ${split[2]}
done < ~/de/links

