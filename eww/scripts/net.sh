#!/bin/zsh


json=$(cat)
iface=$1
action=$2

if [ -f /tmp/eww.net.lock ]; then
  echo "Waiting for lock to be released..." 1>&2
  inotifywait -e delete_self /tmp/eww.net.lock > /dev/null 2>&1
  echo "Lock released!" 1>&2
fi

touch /tmp/eww.net.lock

# if json is {"null":null} set it to {}
# json=$(echo $json | jq -c 'if .null == true then {} else . end')

case $action in
  hover)
    addr=$(ip addr show dev $iface | grep -w inet | cut -d" " -f 6 | cut -d/ -f 1) 
    json=$(echo $json | jq -c ".ifs.\"$iface\" = \"$addr\" | .hover = \"$iface\"")
    # echo $json 1>&2
    eww update network-data=$json
    ;;
  unhover)
    eww update network-data=$(echo $json | jq -c ".hover = null")
    ;;
esac

rm /tmp/eww.net.lock
