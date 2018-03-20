#! /bin/bash

line=$(xrandr | grep " connected ")
output=$(echo $line | cut -f 1 -d " ")
orient=$(echo $line | cut -f 5 -d " ")

if [[ "$orient" == "inverted" ]]; then
  xrandr --output $output --rotate normal
else
  xrandr --output $output --rotate inverted
fi


