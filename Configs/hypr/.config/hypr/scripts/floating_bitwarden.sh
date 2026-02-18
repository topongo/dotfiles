#!/bin/bash

# WARNING: from previous versions this script did opposite from now!
#   - before: the script would find Bitwarden windows and made them floating
#   -    now: the script finds firefox's windows and set them to tiling.
#             by default all firefox windows now must be floating (see `Dependencies`)

# Dependencies: socat, hyprland (duh)
# To automatically load the script add it to your home and add this line to your `hyprland.conf':
#   `exec-once = /path/to/floating_bitwarden.sh`
#   `windowrule = match:class firefox, match:title Mozilla Firefox, float on`

# read from hyprland socket2
socat $XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | \
  while read p; do
    # filter `windowtitlev2` events, from a window that has not "Mozilla Firefox" as his name.
    if ! echo $p | grep -q 'windowtitlev2'; then
      continue
    elif echo $p | grep -q ',Mozilla Firefox'; then
      continue
    fi
    # then for each window that HAS NOT exactly 'Extension: (Bitwarden Password Manager)' as the
    # title we set disable floating:
    #   if we match only 'Bitwarden' every window that contains bitwarden will be matched
    #   eg: searching 'Bitwarden' on google will not trigger it
    if ! echo $p | grep 'windowtitlev2' | grep -q 'Extension: (Bitwarden Password Manager)'; then
      # get the id/address of the window that changed its title
      ADDR="0x$(echo $p | sed -E 's/.*>>(.*),.*/\1/')"
      # set tiling on
      echo $ADDR
      hyprctl dispatch settiled address:$ADDR
    fi
  done
