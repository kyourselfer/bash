#!/bin/bash
# Killing processes signal -9

#set -x
COUNT=$(ps -aux | grep -E 'iostat -xd 1' | wc -l)

if [[ $COUNT -gt 1 ]]
then
#  echo $COUNT
  killall iostat
  echo "Iostat process found and killed correctly by signal -9"
  exit 0
else
  echo "Iostat process hasn't found yet"
  exit 0
fi
