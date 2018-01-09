# dotfiles for Arch Linux

## Dependencies

Probably not an exhaustive list...

 - i3
 - st
 - zsh
 - tmux
 - compton
 - neovim
 - lemonbar with xft and xbm support ([my fork](https://github.com/btolsch/bar))
 - [wschirp](https://github.com/btolsch/wschirp)

## Install

    $ install.sh [override1 [override2]]

``override1`` (if != 0) will allow ``install.sh`` to overwrite existing files with
symlinks to files in this directory.  ``override2`` will do the same for the
subordinate install scripts like ``bin_install.sh``.
