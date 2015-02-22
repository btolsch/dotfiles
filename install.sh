#!/bin/zsh
#override existing non-link regular files with first argument ($1)
#sub-scripts get passed second argument ($2) as their arg

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

for file in $(ls -d .* | grep -v ".git*" | grep -v "install.sh"); do
	if [ ! -e ~/$file ]; then
		ln -s ${rel}/${file} ~/$file
	elif [ ! -L ~/$file ]; then
		echo "~/$file exists and is not a link"
		if [ -n "$1" ]; then
			echo "overwriting ~/$file with link"
			rm -rf ~/$file
			ln -sf $rel/$file ~/$file
		fi
	fi
done

for script in $(ls | grep -E ".install\.sh"); do
	. ./$script $2
done
