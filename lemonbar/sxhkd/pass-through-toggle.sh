#!/bin/bash

pkill -USR2 -x sxhkd
ln -sf ~/dotfiles/sxhkd/normal ~/.config/sxhkd/sxhkdrc
pkill -USR2 -x sxhkd
pkill -USR1 -x sxhkd
