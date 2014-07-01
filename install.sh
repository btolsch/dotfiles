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

for file in $(ls -A); do
	ln -sf ${rel}/${file} ~/$file
done
