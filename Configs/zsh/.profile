#!/bin/zsh

if [[ $0 == "/etc/lightdm/Xsession" ]] && [[ $1 == "i3" ]]; then
  export TERMINAL=konsole
fi

. "$HOME/.cargo/env"
