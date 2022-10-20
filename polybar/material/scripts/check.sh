#!/bin/bash

#Get screen size
# root_geo=$(xwininfo -root | awk -F'[ +]' '$3 ~ /-geometry/ {print $4}')
root_geo="2560x1080"

#infinite loop
while :
do
  #Check if any window fills the screen
  # win_fills=$(xwininfo -root -tree | grep $root_geo)
  # win_fills=$(xwininfo -root -children | grep -v plasma | grep 2560x1080 | wc -l)
  id=$(xdotool getactivewindow)
  win_fills=$(xwininfo -id $id -stats | grep -E '(Width|Height):' | sed 's/ *\(Width\|Height\| \)://' | sed 's/ //' | tr '\n' x | sed 's/.$//')
  win_name=$(xwininfo -id $id -stats | grep -E 'Window id:' | sed 's/.* "//')

  if [[ "$win_name" != *"Plasma"* && $win_fills == $root_geo ]]
    then
      polybar-msg cmd hide
  else
    polybar-msg cmd show
  fi
  #If any window fills the screen hide polybar, otherwise show it

  # if [ $win_fills -le 1 ]
  #   then
  #     polybar-msg cmd show
  # else
  #     polybar-msg cmd hide
  # fi
  sleep 2
done
