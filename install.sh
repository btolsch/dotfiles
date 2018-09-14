#!/bin/zsh
#override existing non-link regular files with first argument ($1)
#sub-scripts get passed second argument ($2) as their arg

dotfiles_dir=$(dirname $(realpath $0))
if [ -z $(echo $dotfiles_dir | sed -n 's#.*\(/dotfiles\)$#\1#p') ]; then
  echo "why is the install script not under the dotfiles directory?"
  echo "no links created"
  exit 1
fi

rel=$(echo $dotfiles_dir | sed -n "s#$HOME/\(.\+\)\$#\1#p" -)
if [ -z $rel ]; then
  echo "dotfiles should be under your home directory"
  echo "no links created"
  exit 1
fi

for file in $(ls -d $dotfiles_dir/.* | grep -v ".git" | grep -v ".config"); do
  file=${file#$dotfiles_dir/}
  if [ ! -e ~/$file ]; then
    ln -s ${rel}/${file} ~/$file
  elif [ ! -L ~/$file ]; then
    echo "~/$file exists and is not a link"
    if [ -n "$1" -a "$1" != "0" ]; then
      echo "overwriting ~/$file with link"
      rm -rf ~/$file
      ln -sf $rel/$file ~/$file
    fi
  fi
done

for script in $(ls $dotfiles_dir | grep -E ".install\.sh"); do
  echo "running $script"
  . $dotfiles_dir/$script $2
done

config_dirs="powerline"
for config_dir in $config_dirs; do
  if [[ ! -e ~/.config/$config_dir ]]; then
    mkdir -p ~/.config
    ln -s ../$rel/$config_dir ~/.config/$config_dir
  elif [ ! -L ~/.config/powerline ]; then
    echo "~/.config/$config_dir exists and is not a link"
    if [ -n "$1" -a "$1" != "0" ]; then
      echo "overwriting ~/.config/$config_dir with link"
      rm -rf ~/.config/$config_dir
      ln -sf ../$rel/$config_dir ~/.config/$config_dir
    fi
  fi
done

typeset -A other_files
other_files=("mpd.conf" ".config/mpd/mpd.conf"
             "redshift.conf" ".config/redshift/redshift.conf"
             "redshift-gtk.service" ".config/systemd/user/redshift-gtk.service"
             "redshift-gtk.service.d" ".config/systemd/user/redshift-gtk.service.d"
             ".vim" ".config/nvim"
             ".vimrc" ".config/nvim/init.vim")
for file in ${(k)other_files}; do
  dest_file=~/${other_files[$file]}
  rel_file=$(realpath $dotfiles_dir/$file --relative-to=$(dirname ~/${other_files[$file]}))
  if [[ ! -e $dest_file ]]; then
    mkdir -p $(dirname $dest_file)
    ln -s $rel_file $dest_file
  elif [[ ! -L $dest_file ]]; then
    echo "$dest_file exists and is not a link"
    if [ -n "$1" -a "$1" != 0 ]; then
      echo "overwriting $dest_file with link"
      ln -sf $rel_file $dest_file
    fi
  fi
done
