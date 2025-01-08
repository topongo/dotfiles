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
  l=${l:gs/\%h/$HOSTNAME}
  split=(${(s/ /)l})
  [ "${split[3]}" = "r" ] && RELATIVE=1 || RELATIVE=0
  if ! [[ -z ${split[2]} ]]; then
    mkdir -p $(basename ${split[2]})
  fi
  if [[ $RELATIVE -eq 1 ]]; then
    ln -vfs ${split[1]} ${split[2]}
  else
    ln -vfs ~/de/${split[1]} ${split[2]}
  fi
done < ~/de/links

