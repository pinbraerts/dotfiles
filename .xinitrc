. ~/.profile
# setxkbmap -option ctrl:swapcaps,grp:toggle -layout us,ru
# xcape -e 'Control_L=Escape' &
picom &
feh --no-fehbg --bg-center /home/pinbraerts/wallpapers/lake.jpg &
xautolock -time 5 -locker slock &
# xrandr --auto --output HDMI1 --right-of eDP1
dbus-launch dwm-start
