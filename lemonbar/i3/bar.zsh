#!/bin/zsh

BAR_DIR=$(dirname $0)/..
BAR_BASE_DIR=$BAR_DIR/base

source $BAR_BASE_DIR/common.sh

MPSTAT_FILE=$(mktemp -u)
mkfifo $MPSTAT_FILE
exec 3<>$MPSTAT_FILE
unlink $MPSTAT_FILE

mpstat 1 >&3 &

GEOMETRY=$(xrandr | grep primary | awk '{ print $4 }' | sed 's/x[0-9]\++/x18+/')

(while :; do
  MPSTAT_NEXT=$(nbline <&3)
  MPSTAT_LINE=$([ ${#MPSTAT_NEXT} -eq 0 ] && echo "$MPSTAT_LINE" || echo "$MPSTAT_NEXT")
  MUSIC=$($BAR_BASE_DIR/music.zsh)
  DROPBOX=$($HOME/bin/dropbox.py status)
  PACMAN=$($BAR_BASE_DIR/pacman.sh)
  NET_INFO=$($BAR_BASE_DIR/network.sh | paste -sd " $SEP ")
  DISKS=$($BAR_BASE_DIR/disk.sh | paste -sd " $SEP ")
  CPU="$(printf "%3.0f" $(echo \"$MPSTAT_LINE\" | awk '/all/ {print 100 - $NF}'))% $SEP $(cat /proc/loadavg | cut -f 1-3 -d ' ')"
  MEM_FIELDS=$(free -b | awk '/Mem/ {x=$2-$NF; print x; printf "%.0f\n", 100*x/$2}')
  MEM_FIELDS=(${(f)MEM_FIELDS})
  MEM="$(echo ${MEM_FIELDS[1]} | numfmt --to=si --format='%6.2f') $(printf '%2d%%' ${MEM_FIELDS[2]})"
  TIME=$(date +"%m.%d.%y %I:%M %p")

  for i in {0..1}; do
    echo -en "%{S$i}%{r}$MUSIC"
    echo -en " %{F$BLUE}\ue0aa%{F-} $DROPBOX"
    echo -en " %{A:$BAR_BASE_DIR/dzen/pacman.sh:}%{F$BLUE}\ue00f%{F-} $PACMAN%{A}"
    echo -en " %{F$BLUE}\ue19c%{F-} $NET_INFO"
    echo -en " %{F$BLUE}\ue147%{F-} $DISKS"
    echo -en " %{F$BLUE}\ue026%{F-}$CPU"
    echo -en " %{F$BLUE}\ue021%{F-}$MEM"
    echo -en " %{F$BLUE}\ue265%{F-} $TIME %{F$BLUE}%{I$DOTFILES_DIR/icons/arch_10x10.xbm}%{F-}"
  done
  echo
  sleep 0.5
done
) | wschirp |
lemonbar -g x18 -F "#888888" -B "#000000" -u 2 -f "Terminess Powerline:size=8" -f "Siji:size=8" | wsfilter | (
while read TURTLE; do
  eval "$TURTLE" &> /dev/null
done)
