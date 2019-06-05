#!/usr/bin/zsh

BAR_DIR=$(dirname $0)/..
BAR_BASE_DIR=$BAR_DIR/base

source $BAR_BASE_DIR/common.sh

MPSTAT_FILE=$(mktemp -u)
mkfifo $MPSTAT_FILE
exec 3<>$MPSTAT_FILE
unlink $MPSTAT_FILE

FIFO_FILE=$(mktemp -u)
mkfifo $FIFO_FILE
exec 4<>$FIFO_FILE
unlink $FIFO_FILE

mpstat 1 >&3 &
bspc subscribe report >&4 &
(while :; do echo "tick" >&4; sleep 0.5; done) &

GEOMETRY=$(xrandr | grep primary | awk '{ print $4 }' | sed 's/x[0-9]\++/x18+/')

(while read -r line <&4; do
  if [ "$line" = "tick" ]; then
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
  else
    desktop=1
    monitor_count=0
    ws="%{+u}"
    IFS=':' array=($(bspc wm --get-status))
    for item in "${array[@]}"; do
      name=${item#?}
      maybe_m=$(echo $item | sed -n 's/^.*\(.\)\(HDMI\|DVI\).*$/\1/p')
      if [ "$maybe_m" = "m" ]; then
        focused="cccccc"
        monitor_count=$((monitor_count+1))
      elif [ "$maybe_m" = "M" ]; then
        focused="0f70bf"
        monitor_count=$((monitor_count+1))
      elif [ "$item" = "LT" -o "$item" = "LM" ]; then
        ws="${ws}%{S+}"
      else
        desk=""
        case $item in
          O*) # focused occupied
            desk="%{U#$focused} ${name} "
          ;;
          F*) # focused free
            desk="%{U#$focused} ${name} "
          ;;
          U*) # focused urgent
            desk="%{U#$focused} ${name} "
          ;;
          o*) # occupied
            desk="%{U#888888} ${name} "
          ;;
          f*) # free
            desk="%{U#000000} ${name} "
          ;;
          u*) # urgent
            desk="%{U#bf700f} ${name} "
          ;;
        esac
        if [ -n "$desk" ]; then
          ws="${ws}%{A:bspc desktop -f ^$desktop:}${desk}%{A}"
          desktop=$((desktop+1))
        fi
      fi
    done
    ws="${ws}%{U-}%{-u}"
  fi
  echo -n "${ws}"
  if [ $(basename $(readlink ~/.config/sxhkd/sxhkdrc)) = pass-through ]; then
    LOGO_COLOR="#aa0000"
  else
    LOGO_COLOR="$BLUE"
  fi
  for i in {0..$((monitor_count-1))}; do
    echo -en "%{S$i}%{r}$MUSIC"
    echo -en " %{F$BLUE}\ue0aa%{F-} $DROPBOX"
    echo -en " %{A:$BAR_BASE_DIR/dzen/pacman.sh:}%{F$BLUE}\ue00f%{F-} $PACMAN%{A}"
    echo -en " %{F$BLUE}\ue19c%{F-} $NET_INFO"
    echo -en " %{F$BLUE}\ue147%{F-} $DISKS"
    echo -en " %{F$BLUE}\ue026%{F-}$CPU"
    echo -en " %{F$BLUE}\ue021%{F-}$MEM"
    echo -en " %{A:$BAR_BASE_DIR/dzen/cal.sh:}%{F$BLUE}\ue265%{F-} $TIME%{A} %{A:$BAR_DIR/sxhkd/pass-through-toggle.sh:}%{F$LOGO_COLOR}%{I$DOTFILES_DIR/icons/arch_10x10.xbm}%{F-}%{A}"
  done
  echo
done
) | # wschirp |
lemonbar -n "lemonbar" -g "x18" -F "#888888" -B "#000000" -a 20 -u 2 -f "Terminess Powerline:size=8" -f "Siji:size=8" | sh &>/dev/null &

for wid in $(xdo id -m -a lemonbar); do
  for bspwm_id in $(xdo id -N Bspwm -n root); do
    xdo above -t "$bspwm_id" "$wid"
  done
done
wait
