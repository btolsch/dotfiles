#!/bin/zsh
mkdir -p ~/bin
rel=$(pwd | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
for file in bin/*; do
	if [ ! -e ~/$file ]; then
		ln -s ../$rel/$file ~/$file
	elif [ ! -L ~/$file ]; then
		echo "~/$file exists and is not a link"
		if [ -n "$1" ]; then
			echo "overwriting ~/$file with link"
			rm -rf ~/$file
			ln -sf ../$rel/$file ~/$file
		fi
	fi
done
