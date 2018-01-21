#!/bin/bash

X=$(($(xdotool getmouselocation | sed 's/^x:\([0-9]\+\).*$/\1/') - 30))
Y=0
pacman -Qu | dzen2 -x $X -y $Y -l 40 -w 350 -fn "Terminess Powerline" -p \
    -e 'onstart=uncollapse,hide,scrollhome,grabkeys;button1=exit;button3=exit;
    ;button4=scrollup;button5=scrolldown;key_j=scrolldown;key_k=scrollup;
    ;key_q=exit;key_Escape=exit'
