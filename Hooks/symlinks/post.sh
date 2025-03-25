#!/bin/sh

echo Copying symlinks
for link in $(ls ../Symlinks); do
  cp --no-dereference --no-target-directory ../Symlinks/$link ~/$link
done
