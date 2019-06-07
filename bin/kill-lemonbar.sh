#!/bin/zsh

while pidof -x bar.zsh &> /dev/null; do
  PIDS=$(for PPID_ in $(pgrep bar.zsh); do
    pgrep -P $PPID_
  done)
  for PPID_ in $(pgrep bar.zsh); do
    kill -9 $PPID_
  done
  for PID_ in $(echo $PIDS); do
    kill -9 $PID_;
  done
done
