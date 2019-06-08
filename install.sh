#!/bin/zsh
#override existing non-link regular files with first argument ($1)
#sub-scripts get passed second argument ($2) as their arg

SELF_DIR=$(dirname $(realpath $0))
pushd $SELF_DIR

PLATFORM_REL_PREFIX=$(realpath --relative-to=$SELF_DIR $HOME/dotfiles)
OVERRIDE=${1:-0}

source install_functions.zsh

for script in $(ls | grep -E ".install\.sh"); do
  echo "running $script"
  source $script $2
done

batch_symlink_install() {
  batch_dict_symlink_install $(paste -d ' ' <(echo $@ | tr ' ' '\n') <(echo $@ | tr ' ' '\n') | tr '\n' ' ')
}

# TODO(btolsch): Rip this out after everyone is ported to the reversed dict
# sense.
if [[ -n $PORTED_FILE_DICT ]]; then
  batch_dict_symlink_install() {
    local -A files
    files=($@)
    for dest_file in ${(k)files}; do
      if [ "${platform_symlink_files[$dest_file]}" = "" ]; then
        file=${files[$dest_file]}
        symlink_install ~/$dest_file $file $OVERRIDE
      fi
    done
  }

  typeset -A other_files
  other_files=(
      ".config/nvim" ".vim"
      ".config/nvim/init.vim" ".vimrc"
      ".config/mpd/mpd.conf" "mpd.conf"
      ".config/powerline" "powerline"
      ".config/systemd/user/redshift-gtk.service" "redshift-gtk.service"
      ".config/systemd/user/redshift-gtk.service.d" "redshift-gtk.service.d"
      ".config/redshift/redshift.conf" "redshift.conf"
      ".config/sxhkd/sxhkdrc" "sxhkd/normal"
  )
  batch_symlink_install $(ls -d .* | grep -v ".git")
  batch_symlink_install bin/*
  batch_dict_symlink_install ${(kv)other_files}
  for dest_file in ${(k)platform_symlink_files}; do
    file=${platform_symlink_files[$dest_file]}
    symlink_install ~/$dest_file $PLATFORM_REL_PREFIX/${platform_symlink_prefixes[$dest_file]}/$file $1
  done
else
  batch_dict_symlink_install() {
    local -A files
    files=($@)
    for file in ${(k)files}; do
      if [ "${platform_symlink_files[$file]}" = "" ]; then
        dest_file=~/${files[$file]}
        symlink_install $dest_file $file $OVERRIDE
      fi
    done
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
  batch_symlink_install $(ls -d .* | grep -v ".git")
  batch_symlink_install bin/*
  batch_dict_symlink_install ${(kv)other_files}
  for file in ${(k)platform_symlink_files}; do
    dest_file=~/${platform_symlink_files[$file]}
    symlink_install $dest_file $PLATFORM_REL_PREFIX/${platform_symlink_prefixes[$file]}/$file $1
  done
fi

popd
