xrdb -load $HOME/.Xresources
flock ~/bin/xset.sh xset r rate 150 25
xrandr --output HDMI-0 --primary --left-of DVI-D-0
#setxkbmap -option grp:alt_shift_toggle us,de
exec bspwm
