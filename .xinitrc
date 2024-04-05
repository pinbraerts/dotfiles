#!/bin/sh
# setxkbmap -option ctrl:swapcaps,grp:toggle -layout us,ru
# xcape -e 'Control_L=Escape' &
# xrandr --auto --output HDMI1 --right-of eDP1
dbus-launch --exit-with-x11 dwm-start
