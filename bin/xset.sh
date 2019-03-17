#!/bin/bash
su btolsch -c 'pgrep -x xset &>/dev/null || DISPLAY=:0 xset r rate 150 25'
