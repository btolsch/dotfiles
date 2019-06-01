#!/bin/zsh

xbacklight $@
notify-send --urgency=low -t 1500 "brightness $(xbacklight -get | sed 's/\..*$//')"
