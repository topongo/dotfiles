#!/bin/bash

killall -q fusuma

# Wait until the processes have been shut down
while pgrep -u $UID -x fusuma >/dev/null; do sleep 1; done

fusuma

