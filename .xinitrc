xrdb -load $HOME/.Xresources
flock ~/bin/xset.sh xset r rate 150 25
#setxkbmap -option grp:alt_shift_toggle us,de
exec i3
