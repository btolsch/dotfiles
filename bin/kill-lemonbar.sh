#!/bin/bash

pidof -x bar.zsh &> /dev/null && kill -9 -- -$(cat /proc/$(pgrep bar.zsh | head -1)/stat | awk '{ print $5 }')
