#!/bin/bash
rel=$(pwd | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
if [ ! -e ~/.config/terminator/config ]; then
	mkdir -p ~/.config/terminator
	ln -s ../../$rel/terminator_config ~/.config/terminator/config
elif [ ! -L ~/.config/terminator/config ]; then
	echo "~/.config/terminator/config exists and is not a link"
	if [ -n "$1" ]; then
		echo "overwriting ~/.config/terminator/config with link"
		ln -sf ../../$rel/terminator_config ~/.config/terminator/config
	fi
fi
