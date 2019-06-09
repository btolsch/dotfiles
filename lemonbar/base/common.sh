#!/bin/bash

BLUE="#1793d1"
SEP="%{F$BLUE}\u2502%{F-}"
DOTFILES_DIR=$(realpath $0 | sed 's#\(/dotfiles/base\)\(/.*\)$#\1#')
