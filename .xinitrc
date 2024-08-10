#!/bin/sh
sxhkd &
pipewire &
bluetooth-menu &
dex -a & # autostart
setxkbmap -option grp:toggle -layout us,ru
/usr/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit &
feh --no-fehbg --bg-center /home/pinbraerts/wallpapers/lake.jpg & # wallpapers
xset +dpms dpms 0 300 300 &
lock enable &
bar.sh &
rxbanish -i all >/dev/null 2>&1 &
