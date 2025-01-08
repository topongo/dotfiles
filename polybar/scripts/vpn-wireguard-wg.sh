#!/bin/sh

case $(sudo wg show 2>/dev/null | head -1 | awk '{ print $NF }') in
  prabo.local)
    echo "󰳋"
    ;;
  prabo.org)
    echo "󰳌"
    ;;
  *)
    echo "󰦜"
    ;;
esac


