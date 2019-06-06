#!/bin/zsh

get_rel_path() {
  realpath $1 --relative-to=$(dirname $2)
}

symlink_install() {
  dest_file=$1
  file=$2
  override=$3

  rel_file=$(get_rel_path $file $dest_file)
  if [ ! -e $dest_file -a ! -L $dest_file ]; then
    mkdir -p $(dirname $dest_file)
    ln -s $rel_file $dest_file
  # resolves
  elif [ ! -L $dest_file ]; then
    echo "$dest_file exists and is not a link"
    if [ -n "$override" -a "$override" != 0 ]; then
      echo "overwriting $dest_file with link ($rel_file)"
      ln -snf $rel_file $dest_file
    fi
  # !resolves && paths differ
  elif [ "$(readlink -f $dest_file)" != "$(realpath $file)" ]; then
    echo "$dest_file exists, and is a link, but points somewhere else ($(readlink -f $dest_file) vs. $rel_file)"
    if [ -n "$override" -a "$override" != 0 ]; then
      echo "overwriting $dest_file with different link ($rel_file)"
      ln -snf $rel_file $dest_file
    fi
  else
    echo "okay: $dest_file"
  fi
}
