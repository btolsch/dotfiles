#!/bin/bash
mkdir -p ~/.config
if [[ ! -e ~/.config/powerline ]]; then
	ln -s ~/dotfiles/powerline ~/.config/powerline
fi
