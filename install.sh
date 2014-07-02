#!/bin/bash

if [ -z $(pwd | sed -n 's#.*\(/dotfiles\)$#\1#p') ]; then
	echo "run this script from the dotfiles directory"
	echo "no links created"
	exit
fi

rel=$(pwd | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
if [ -z "$rel" ]; then
	echo "dotfiles should be under your home directory"
	echo "no links created"
	exit
fi

for file in $(ls -A | grep -v ".git*" | grep -v "install.sh"); do
	if [ ! -e ~/$file ]; then
		ln -s ${rel}/${file} ~/$file
	fi
done

for script in $(ls | grep -E ".install\.sh"); do
	. $script
done
