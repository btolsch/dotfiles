xrdb -load $HOME/.Xresources
dunst &
xscreensaver -no-splash &
exec $1
