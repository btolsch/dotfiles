#!/bin/zsh
#override existing non-link regular files with first argument ($1)
#sub-scripts get passed second argument ($2) as their arg

dotfiles_dir=$(dirname $(realpath $0))
pushd $dotfiles_dir

for script in $(ls | grep -E ".install\.sh"); do
  echo "running $script"
  source $script $2
done

get_rel_path() {
  realpath $1 --relative-to=$(dirname $2)
}

symlink_install() {
  dest_file=$1
  rel_file=$2
  override=$3
  if [ ! -e $dest_file -a ! -L $dest_file ]; then
    echo "!resolves && !L: $dest_file"
    mkdir -p $(dirname $dest_file)
    ln -s $rel_file $dest_file
  # resolves
  elif [ ! -L $dest_file ]; then
    echo "$dest_file exists and is not a link"
    if [ -n "$override" -a "$override" != 0 ]; then
      echo "overwriting $dest_file with link"
      ln -sf $rel_file $dest_file
    fi
  # !resolves && paths differ
  elif [ "$(readlink -f $dest_file)" != "$(realpath $file)" ]; then
    echo "$dest_file exists, and is a link, but points somewhere else"
    if [ -n "$override" -a "$override" != 0 ]; then
      echo "overwriting $dest_file with different link"
      ln -sf $rel_file $dest_file
    fi
  else
    echo "okay: $dest_file"
  fi
}

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
  dest_file=~/$file
  rel_file=$(get_rel_path $file $dest_file)
  symlink_install $dest_file $rel_file $1
done
for file in bin/*; do
  dest_file=~/$file
  rel_file=$(get_rel_path $file $dest_file)
  symlink_install $dest_file $rel_file $1
done
for file in ${(k)other_files}; do
  dest_file=~/${other_files[$file]}
  rel_file=$(get_rel_path $file $dest_file)
  symlink_install $dest_file $rel_file $1
done

popd
