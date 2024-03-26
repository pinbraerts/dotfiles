#!/usr/bin/env sh
pipewire &
Telegram -startintray &
/usr/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit &
bluetooth-menu &
dex -a &
