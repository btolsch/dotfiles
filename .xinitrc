xrdb -load $HOME/.Xresources
xscreensaver -nosplash &
xset r rate 150 25
exec $1
