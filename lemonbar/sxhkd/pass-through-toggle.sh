#!/bin/bash

CONFIG_FILE=~/.config/sxhkd/sxhkdrc
pkill -USR2 -x sxhkd
ln -sf $([ "$(readlink $CONFIG_FILE)" = "$(realpath ~/dotfiles/sxhkd/normal)" ] && echo ~/dotfiles/sxhkd/pass-through || echo ~/dotfiles/sxhkd/normal) $CONFIG_FILE
pkill -USR2 -x sxhkd
pkill -USR1 -x sxhkd
