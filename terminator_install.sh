#!/bin/bash
rm -f ~/.terminator_config
mkdir -p ~/.config/terminator
ln -sf ~/dotfiles/.terminator_config ~/.config/terminator/config
