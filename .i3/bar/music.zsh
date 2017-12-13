#!/bin/zsh

BAR_DIR=$(dirname $(realpath $0))

. $BAR_DIR/common.sh

MPC_LINES=$(mpc status)
MPC_LINES=(${(f)MPC_LINES})
if [ ${#MPC_LINES} -le 1 ]; then
  exit
fi
if echo ${MPC_LINES[2]} | grep -q '^\[playing\]'; then
  echo -en "%{F$BLUE}\ue0fe%{F-} "
else
  echo -en "%{F$BLUE}\ue09b%{F-} "
fi
echo -en "${MPC_LINES[1]}$SEP$(echo ${MPC_LINES[2]} | awk '{print $3}')"
echo -n " %{F$BLUE}%{I$DOTFILES_DIR/icons/eq.xbm}%{F-} "

if [ $(pulseaudio-ctl full-status | cut -f 2 -d ' ') = "yes" ]; then
  echo -en "%{F$BLUE}\ue202%{F-} "
else
  echo -en "%{F$BLUE}\ue203%{F-} "
fi
echo -en "$(echo ${MPC_LINES[3]} | awk '{print $2}')"
