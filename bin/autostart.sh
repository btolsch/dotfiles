#!/bin/sh
[[ -f /usr/bin/VBoxClient-all ]] && /usr/bin/VBoxClient-all
source ~/.fehbg
xset r rate 150 25
xinput set-prop 14 268 2
systemctl --user start dropbox
systemctl --user start redshift-gtk
#and look into options like ncache and the repainting options
#also maybe want to save a couple past logs...
#x11vnc -display $DISPLAY -usepw -o ~/.vnc/x11vnc.log -forever &>~/.vnc/x11vnc.port &
#disown