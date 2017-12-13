#!/bin/zsh

mkdir -p ~/.icons
dotfiles_dir=$(dirname $(realpath $0))
rel=$(echo $dotfiles_dir | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
if [ ! -e ~/.icons/dzen2 ]; then
  ln -s ../$rel/icons ~/.icons/dzen2
elif [ ! -L ~/.icons/dzen2 ]; then
  echo "~/.icons/dzen2 exists and is not a link"
  if [ -n "$1" -a "$1" != "0" ]; then
    echo "overwriting ~/.icons/dzen2 with link"
    rm -rf ~/.icons/dzen2
    ln -sf ../$rel/$file ~/.icons/dzen2
  fi
fi
