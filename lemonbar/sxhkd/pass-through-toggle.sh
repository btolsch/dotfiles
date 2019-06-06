#!/bin/bash

source $(dirname $(realpath $0))/../base/common.sh

CONFIG_FILE=~/.config/sxhkd/sxhkdrc
pkill -USR2 -x sxhkd
ln -sf $([ "$(readlink $CONFIG_FILE)" = "$(realpath $DOTFILES_DIR/sxhkd/normal)" ] && echo $DOTFILES_DIR/sxhkd/pass-through || echo $DOTFILES_DIR/sxhkd/normal) $CONFIG_FILE
pkill -USR2 -x sxhkd
pkill -USR1 -x sxhkd
