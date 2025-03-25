#!/bin/sh

cd ~/.config/dotfiles

for link in $(ls Symlinks); do
  cp --no-dereference --no-target-directory Symlinks/$link ~/$link
done
