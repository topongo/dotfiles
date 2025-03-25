#!/bin/sh

# ensure ~/bin is a directory and not a symlink
[ -L ~/bin ] && exit 1
[ -d ~/bin ] || mkdir -p ~/bin
