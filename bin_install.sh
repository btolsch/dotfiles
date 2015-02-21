#!/bin/zsh
rel=$(pwd | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
for file in bin/*; do
	if [ ! -e ~/$file ]; then
		ln -s ../$rel/$file ~/$file
	fi
done
