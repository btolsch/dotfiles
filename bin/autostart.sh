#!/bin/sh
[[ -f /usr/bin/VBoxClient-all ]] && /usr/bin/VBoxClient-all
source ~/.fehbg
xinput set-prop 14 268 2
(ps uxc | grep dropbox) || dropbox
#and look into options like ncache and the repainting options
#also maybe want to save a couple past logs...
#x11vnc -display $DISPLAY -usepw -o ~/.vnc/x11vnc.log -forever &>~/.vnc/x11vnc.port &
#disown
