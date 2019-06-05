#!/bin/zsh

BAR_DIR=$(dirname $(realpath $0))

source $BAR_DIR/common.sh

BAT_LINES=(${(s:, :)$(acpi -b | sed 's/[^:]*: //')})

if acpi -a | grep -q "on-line"; then
  echo -en "%{F$BLUE}\ue042%{F-}"
else
  echo -en "%{F$BLUE}\ue248%{F-}"
fi

echo -n "${BAT_LINES[1][1]} ${BAT_LINES[2]}"
if [ ${#BAT_LINES} -eq 3 ] &&
    echo "${BAT_LINES[3]}" |
      sed -n '/[0-9][0-9]\?\(:[0-9][0-9]\?\(:[0-9][0-9]\?\)\?\)\?/q0;q1'; then
  echo -n " $(echo ${BAT_LINES[3]} | sed 's/\([0-9]\) [a-zA-Z ]*$/\1/')"
fi
