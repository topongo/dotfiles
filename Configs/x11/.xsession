export TERMINAL=alacritty
export MOZ_USE_XINPUT2=1

setxkbmap -option compose:menu

xsession_d="$HOME/.xsession.d"
if [ -d "$xsession_d" ]; then
    for script in $xsession_d/*; do
        . "$script"
    done
fi
