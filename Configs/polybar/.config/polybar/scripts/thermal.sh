#!/bin/zsh

! [ -z $1 ] && sensor=$1 || sensor="thermal_zone0/temp"

cat /sys/class/thermal/$sensor | sed 's/000$/ C°/'
