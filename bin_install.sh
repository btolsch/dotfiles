#!/bin/zsh
mkdir -p ~/bin
dotfiles_dir=$(dirname $(realpath $0))
rel=$(echo $dotfiles_dir | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
for file in $dotfiles_dir/bin/*; do
  file=${file#$dotfiles_dir/}
  if [ ! -e ~/$file ]; then
    ln -s ../$rel/$file ~/$file
  elif [ ! -L ~/$file ]; then
    echo "~/$file exists and is not a link"
    if [ -n "$1" -a "$1" != "0" ]; then
      echo "overwriting ~/$file with link"
      rm -rf ~/$file
      ln -sf ../$rel/$file ~/$file
    fi
  fi
done
