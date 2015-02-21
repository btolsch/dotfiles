#!/bin/zsh
BG=/usr/share/slim/themes/default/background.jpg
NEWBG=~/pictures7/Wallpapers/Misc/linux-www-wallpaper-hd-computer-photo-linux-wallpaper.jpg
if [ -f $BG ]; then
	if [ ! -L $BG ]; then
		mv -f $BG ${BG}.bak 2>/dev/null ||
		  { echo "You don't have permission to write to ${BG%background.jpg}"; exit 1}
	fi
fi
ln -sf $NEWBG $BG 2>/dev/null || 
  echo "You don't have permission to write to ${BG%background.jpg}"
