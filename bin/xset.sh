#!/bin/bash
su btolsch -c 'pgrep -x startx &>/dev/null && DISPLAY=:0 flock ~/bin/xset.sh xset r rate 150 25'
