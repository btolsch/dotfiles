xrdb -load $HOME/.Xresources
xset r rate 150 25
pkill ssh-agent
eval $(ssh-agent -s)
#setxkbmap -option grp:alt_shift_toggle us,de
exec i3
