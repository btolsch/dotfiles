#!/bin/zsh

xbacklight $@
notify-send --urgency=low -t 800 "brightness $(xbacklight -get | sed 's/\..*$//')"
