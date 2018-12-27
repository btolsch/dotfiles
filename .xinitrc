tpset() { xinput set-prop "TPPS/2 IBM TrackPoint" "$@"; }
xrdb -load $HOME/.Xresources
xset r rate 150 25
tpset "Evdev Wheel Emulation" 1
tpset "Evdev Wheel Emulation Button" 2
tpset "Evdev Wheel Emulation Timeout" 200
tpset "Evdev Wheel Emulation Axes" 6 7 4 5
tpset "Device Accel Constant Deceleration" 0.4
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Accel Constant Deceleration" 20
xinput set-prop "Synaptics TM2668-002" "Device Accel Constant Deceleration" 20
xrandr --newmode 1920x1080_60 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode eDP1 1920x1080_60
xrandr --output eDP1 --mode 1920x1080_60
#setxkbmap -option grp:alt_shift_toggle us,de
exec i3
