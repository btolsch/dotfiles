#!/bin/bash
PID=$(pgrep gnome-session)
file=$(~/bin/wall.py)
if [[ $file ]]; then
	if [ $PID ]; then
		export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)
		gsettings set org.gnome.desktop.background picture-uri file://$file
	fi
	DISPLAY=:0 feh --bg-scale $file
	DISPLAY=:20 feh --bg-scale $file
	#ln -sf $file /usr/share/slim/themes/default/background.jpg
fi
