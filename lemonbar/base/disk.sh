#!/bin/bash
SIZE_H=$(df -h | awk '
  {
    if ($6 ~ /^\/$/) {
      print $4
    }
  }
')
FRACTION=$(df | awk '
  {
    if ($6 ~ /^\/$/) {
      printf "%.0f\n", $4/$2*100
    }
  }
' | sed 's/\..*$//')
echo "/ $SIZE_H $FRACTION%"
