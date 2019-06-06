#!/bin/zsh

add_paths_before() {
  local PATH=$1
  shift
  APPEND=""
  for X in $@; do
    if [[ ! "$APPEND:$PATH" == *$X* ]]; then
      APPEND=$APPEND$X:
    fi
  done
  echo $APPEND$PATH
}

add_paths_after() {
  local PATH=$1
  shift
  for X in $@; do
    if [[ ! "$PATH" == *$X* ]]; then
      PATH=$PATH:$X
    fi
  done
  echo $PATH
}
