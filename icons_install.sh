#!/bin/zsh

rel=$(pwd | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
if [ ! -e ~/.icons/dzen2 ]; then
	ln -s ../$rel/icons ~/.icons/dzen2
elif [ ! -L ~/.icons/dzen2 ]; then
	echo "~/.icons/dzen2 exists and is not a link"
	if [ -n "$1" ]; then
		echo "overwriting ~/.icons/dzen2 with link"
		rm -rf ~/.icons/dzen2
		ln -sf ../$rel/$file ~/.icons/dzen2
	fi
fi
