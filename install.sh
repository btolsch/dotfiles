#!/bin/zsh
#override existing non-link regular files with first argument ($1)
#sub-scripts get passed second argument ($2) as their arg

dotfiles_dir=$(dirname $(realpath $0))
pushd $dotfiles_dir

source install_functions.zsh

for script in $(ls | grep -E ".install\.sh"); do
  echo "running $script"
  source $script $2
done

typeset -A other_files
other_files=(
    ".vim" ".config/nvim"
    ".vimrc" ".config/nvim/init.vim"
    "mpd.conf" ".config/mpd/mpd.conf"
    "powerline" ".config/powerline"
    "redshift-gtk.service" ".config/systemd/user/redshift-gtk.service"
    "redshift-gtk.service.d" ".config/systemd/user/redshift-gtk.service.d"
    "redshift.conf" ".config/redshift/redshift.conf"
    "sxhkd/normal" ".config/sxhkd/sxhkdrc"
)
for file in $(ls -d .* | grep -v ".git" | grep -v ".config"); do
  if [ "${platform_symlink_files[$file]}" = "" ]; then
    dest_file=~/$file
    rel_file=$(get_rel_path $file $dest_file)
    symlink_install $dest_file $rel_file $1
  fi
done
for file in bin/*; do
  dest_file=~/$file
  rel_file=$(get_rel_path $file $dest_file)
  symlink_install $dest_file $rel_file $1
done
for file in ${(k)other_files}; do
  if [ "${platform_symlink_files[$file]}" = "" ]; then
    dest_file=~/${other_files[$file]}
    rel_file=$(get_rel_path $file $dest_file)
    symlink_install $dest_file $rel_file $1
  fi
done

popd
