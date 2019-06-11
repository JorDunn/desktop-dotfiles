#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ $m == "DisplayPort-2" ]; then
      export TRAY_POS="right"
    else
      export TRAY_POS=""
    fi
    MONITOR=$m polybar --reload -q example &
    echo $m
  done
else
  polybar --reload -q example &
fi
