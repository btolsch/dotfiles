#!/bin/bash
PID=$(pgrep gnome-session)
file=$(~/bin/wall.py)
if [[ $file ]]; then
  if [ $PID ]; then
    export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)
    gsettings set org.gnome.desktop.background picture-uri file://$file
  fi
  for disp in $(cd /tmp/.X11-unix && for x in X*; do echo ":${x#X}"; done); do
    DISPLAY=$disp feh --bg-scale $file
  done
fi
