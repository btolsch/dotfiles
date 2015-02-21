#!/bin/zsh
BG=/usr/share/slim/themes/default/background.jpg
NEWBG=~/pictures7/Wallpapers/Misc/linux-www-wallpaper-hd-computer-photo-linux-wallpaper.jpg
if [ -f $BG ]; then
	if [ ! -L $BG ]; then
		mv $BG ${BG}.bak ||
		  (echo "You don't have permission to write to ${BG%background.jpg}" &&
		  exit 1)
	fi
	ln -sf $NEWBG $BG || 
	  echo "You don't have permission to write to ${BG%background.jpg}"
fi
