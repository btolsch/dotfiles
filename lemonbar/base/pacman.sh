#!/bin/bash

NUM_UPDATES=$(pacman -Qu | wc -l)
if [ $NUM_UPDATES -eq 0 ]; then
  echo -n "Up to date"
elif [ $NUM_UPDATES -eq 1 ]; then
  echo -n "1 update"
else
  echo -n "$NUM_UPDATES updates"
fi
