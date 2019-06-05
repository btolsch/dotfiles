#!/bin/zsh

init() {
  source $BAR_DIR/base/common.sh

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

  SELECT_FD=4
}

on_tick() {
  MPSTAT_NEXT=$(nbline <&3)
  MPSTAT_LINE=$([ ${#MPSTAT_NEXT} -eq 0 ] && echo "$MPSTAT_LINE" || echo "$MPSTAT_NEXT")
  MUSIC=$($BAR_DIR/base/music.zsh)
  DROPBOX=$($HOME/bin/dropbox.py status)
  NET_INFO=$($BAR_DIR/base/network.sh | paste -sd " $SEP ")
  DISKS=$($BAR_DIR/base/disk.sh | paste -sd " $SEP ")
  CPU="$(printf "%3.0f" $(echo \"$MPSTAT_LINE\" | awk '/all/ {print 100 - $NF}'))% $SEP $(cat /proc/loadavg | cut -f 1-3 -d ' ')"
  MEM_FIELDS=$(free -b | awk '/Mem/ {x=$2-$NF; print x; printf "%.0f\n", 100*x/$2}')
  MEM_FIELDS=(${(f)MEM_FIELDS})
  MEM="$(echo ${MEM_FIELDS[1]} | numfmt --to=si --format='%6.2f') $(printf '%2d%%' ${MEM_FIELDS[2]})"
  TIME=$(date +"%m.%d.%y %I:%M %p")
}

on_bspwm_report() {
  DESKTOP_INDEX=1
  MONITOR_COUNT=0
  WS="%{+u}"
  IFS=':' array=($(bspc wm --get-status))
  for item in "${array[@]}"; do
    name=${item#?}
    maybe_m=$(echo $item | sed -n 's/^.*\(.\)\(HDMI\|DVI\|eDP\|DP-\?[0-9]\).*$/\1/p')
    if [ "$maybe_m" = "m" ]; then
      FOCUSED="cccccc"
      MONITOR_COUNT=$((MONITOR_COUNT+1))
    elif [ "$maybe_m" = "M" ]; then
      FOCUSED="0f70bf"
      MONITOR_COUNT=$((MONITOR_COUNT+1))
    elif [ "$item" = "LT" -o "$item" = "LM" ]; then
      WS="${WS}%{S+}"
    else
      DESK=""
      case $item in
        O*) # focused occupied
          DESK="%{U#$FOCUSED} ${name} "
        ;;
        F*) # focused free
          DESK="%{U#$FOCUSED} ${name} "
        ;;
        U*) # focused urgent
          DESK="%{U#$FOCUSED} ${name} "
        ;;
        o*) # occupied
          DESK="%{U#888888} ${name} "
        ;;
        f*) # free
          DESK="%{U#000000} ${name} "
        ;;
        u*) # urgent
          DESK="%{U#bf700f} ${name} "
        ;;
      esac
      if [ -n "$DESK" ]; then
        WS="${WS}%{A:bspc desktop -f ^$DESKTOP_INDEX:}${DESK}%{A}"
        DESKTOP_INDEX=$((DESKTOP_INDEX+1))
      fi
    fi
  done
  WS="${WS}%{U-}%{-u}"
}

pre_render() {
  if [ $(basename $(readlink ~/.config/sxhkd/sxhkdrc)) = pass-through ]; then
    LOGO_COLOR="#aa0000"
  else
    LOGO_COLOR="$BLUE"
  fi
}

render_left() {
  echo -n "${WS}"
}

render_right() {
  for i in {0..$((MONITOR_COUNT-1))}; do
    echo -en "%{S$i}%{r}$MUSIC"
    echo -en " %{F$BLUE}\ue0aa%{F-} $DROPBOX"
    echo -en "$1"
    echo -en " %{F$BLUE}\ue19c%{F-} $NET_INFO"
    echo -en " %{F$BLUE}\ue147%{F-} $DISKS"
    echo -en " %{F$BLUE}\ue026%{F-}$CPU"
    echo -en " %{F$BLUE}\ue021%{F-}$MEM"
    echo -en " %{A:$BAR_BASE_DIR/dzen/cal.sh:}%{F$BLUE}\ue265%{F-} $TIME%{A} %{A:$BAR_DIR/sxhkd/pass-through-toggle.sh:}%{F$LOGO_COLOR}%{I$DOTFILES_DIR/icons/arch_10x10.xbm}%{F-}%{A}"
  done
  echo
}

invoke_lemonbar() {
  lemonbar -n "lemonbar" -g "x$BAR_HEIGHT" -F "#888888" -B "#000000" -a 20 -u 2 -f "Terminess Powerline:size=$BAR_FONT_SIZE" -f "Siji:size=$BAR_FONT_SIZE" <&0 | sh &>/dev/null &

  for wid in $(xdo id -m -a lemonbar); do
    for bspwm_id in $(xdo id -N Bspwm -n root); do
      xdo above -t "$bspwm_id" "$wid"
    done
  done
  wait
}
