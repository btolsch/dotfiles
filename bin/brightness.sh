#!/bin/zsh

max_bright=$(cat /sys/class/backlight/intel_backlight/max_brightness)
actual_bright=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
if [[ $1 = "inc" ]]; then
	new_bright=$(python -c "from math import ceil; print(min($max_bright, ceil($actual_bright + 0.05*$max_bright)))")
elif [[ $1 = "dec" ]]; then
	new_bright=$(python -c "from math import ceil; print(max(0, ceil($actual_bright - 0.05*$max_bright)))")
else
	exit 1
fi
echo $new_bright > /sys/class/backlight/intel_backlight/brightness
