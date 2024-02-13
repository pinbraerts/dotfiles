setxkbmap -option ctrl:swapcaps,grp:toggle -layout us,ru
xcape -e 'Control_L=Escape' &
picom &
feh --no-fehbg --bg-center /home/pinbraerts/wallpapers/lake.jpg &
pipewire &
Telegram -startintray &
xautolock -time 5 -locker slock &
# xrandr --auto --output HDMI1 --right-of eDP1
/usr/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit &
/home/pinbraerts/opt/Bluetooth-Menu/bluetooth-menu &
xbindkeys &
dbus-launch dwm-start
