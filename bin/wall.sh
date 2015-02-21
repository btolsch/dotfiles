#!/bin/bash
PID=$(pgrep gnome-session)
file=$(/home/btolsch/bin/wall.py)
if [ "$?" -eq "0" ]; then
	if [ $PID ]; then
		export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)
		gsettings set org.gnome.desktop.background picture-uri file://$file
	fi
	DISPLAY=:0.0 feh --bg-scale $file
	#ln -sf $file /usr/share/slim/themes/default/background.jpg
fi
