#!/bin/zsh
fc-cache -vf ~/.fonts >/dev/null
if [ -e /etc/fonts/conf.d/70-no-bitmaps.conf ]; then
  echo "Warning: remove /etc/fonts/conf.d/70-no-bitmaps.conf to use bitmap fonts like Terminess Powerline"
fi
