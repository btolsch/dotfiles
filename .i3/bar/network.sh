#!/bin/bash
ip addr | awk '
  /^[0-9]+:.*state UP/ { x=substr($2,0,length($2)-1) }
  /inet .*global/ {
    sub(/\/[0-9]+/, "", $2)
    print x, $2
  }
'
