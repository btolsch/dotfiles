#!/bin/sh
source ~/.fehbg
systemctl --user start redshift-gtk
pidof -x xscreensaver &> /dev/null || xscreensaver -nosplash &
# Don't run xscreensaver on chrome remote desktop
[[ "$DISPLAY" != ":0" ]] && xscreensaver-command -exit
pidof -x dropbox &>/dev/null || dropbox
pidof -x conky &> /dev/null || conky &
pidof -x udiskie &> /dev/null || udiskie -2 --tray &
#and look into options like ncache and the repainting options
#also maybe want to save a couple past logs...
#x11vnc -display $DISPLAY -usepw -o ~/.vnc/x11vnc.log -forever &>~/.vnc/x11vnc.port &
#disown
