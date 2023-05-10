#!/bin/bash

x_pos=0
y_pos=0

screen_width=$(tput cols)
screen_height=$(tput lines)

font_color='\033[1;33'
bg_color='\033[40m'

clock_text="`date +'%r'`"

a=48271
m=2147483647 
seed=`date +%s` 


update_interval=3

while true; do
  seed=$((a * seed % m))
  x_pos=$((seed % (screen_width - ${#clock_text})))
  seed=$((a * seed % m))
  y_pos=$((seed % (screen_height - 1)))
  clear
  tput cup $y_pos $x_pos
  clock_text="`date +'%r'`"

  echo -e "${font_color}${bg_color}${clock_text}\033[0m"


  sleep $update_interval
done
