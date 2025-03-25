#!/bin/zsh


json=$(cat)
iface=$1
action=$2

# if json is {"null":null} set it to {}
# json=$(echo $json | jq -c 'if .null == true then {} else . end')

flock -n /tmp/eww.net.lock -c 'echo -n' || exit 1

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
  off)
    nmcli r wifi $(nmcli r wifi | grep -q enabled && echo off || echo on)
    ;;
esac

flock -u /tmp/eww.net.lock
