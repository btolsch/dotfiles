#!/bin/zsh

rel=$(pwd | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
if [ ! -e ~/.icons/dzen2 ]; then
	ln -s ../$rel/icons ~/.icons/dzen2
fi
