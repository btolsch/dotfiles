#!/bin/bash
rel=$(pwd | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
if [[ ! -e ~/.config/powerline ]]; then
	mkdir -p ~/.config
	ln -s ../$rel/powerline ~/.config/powerline
elif [ ! -L ~/.config/powerline ]; then
	echo "~/.config/powerline exists and is not a link"
	if [ -n "$1" ]; then
		echo "overwriting ~/.config/powerline with link"
		rm -rf ~/.config/powerline
		ln -sf ../$rel/powerline ~/.config/powerline
	fi
fi
