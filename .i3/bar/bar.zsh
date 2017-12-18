#!/bin/zsh

BAR_DIR=$(dirname $0)

. $BAR_DIR/common.sh

(while :; do
  MUSIC=$($BAR_DIR/music.zsh)
  DROPBOX=$($HOME/bin/dropbox.py status)
  PACMAN=$($BAR_DIR/pacman.sh)
  NET_INFO=$($BAR_DIR/network.sh | paste -sd " $SEP ")
  DISKS=$($BAR_DIR/disk.sh | paste -sd " $SEP ")
  CPU="$(printf "%.0f" $(mpstat | awk '/all/ {print 100 - $NF}'))% $SEP $(cat /proc/loadavg | cut -f 1-3 -d ' ')"
  MEM_FIELDS=$(free -b | awk '/Mem/ {x=$2-$NF; print x; printf "%.0f\n", 100*x/$2}')
  MEM_FIELDS=(${(f)MEM_FIELDS})
  MEM="$(echo ${MEM_FIELDS[1]} | numfmt --to=si --format='%.2f') ${MEM_FIELDS[2]}%"
  TIME=$(date +"%m.%d.%y %I:%M %p")

  echo -en "%{r}$MUSIC"
  echo -en " %{F$BLUE}\ue0aa%{F-} $DROPBOX"
  echo -en " %{F$BLUE}\ue00f%{F-} $PACMAN"
  echo -en " %{F$BLUE}\ue19c%{F-} $NET_INFO"
  echo -en " %{F$BLUE}\ue147%{F-} $DISKS"
  echo -en " %{F$BLUE}\ue026%{F-}$CPU"
  echo -en " %{F$BLUE}\ue021%{F-}$MEM"
  echo -e " %{F$BLUE}\ue265%{F-} $TIME %{F$BLUE}%{I$DOTFILES_DIR/icons/arch_10x10.xbm}%{F-}"
  sleep 0.5
done
) | wschirp | (
while read TURTLE; do
  echo "$TURTLE"
done) | lemonbar -F "#888888" -B "#000000" -u 2 -f "Terminess Powerline:size=8" -f "Wuncon Siji:size=8" | wsfilter | (
while read TURTLE; do
  eval "$TURTLE"
done)
