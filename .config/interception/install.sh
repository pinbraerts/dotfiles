#!/bin/sh

directory=$(readlink -f $(dirname $0))

if test -x xbps-install; then
	sudo xbps-install -S interception-tools
elif test -x nala; then
	sudo add-apt-repository ppa:deafmute/interception
	sudo nala install interception-tools
elif test -x pacman; then
	sudo pacman -S interception-tools
elif test -x apt; then
	sudo add-apt-repository ppa:deafmute/interception
    sudo apt update
	sudo apt install interception-tools interception-tools-compat
elif test -x apt-get; then
	sudo add-apt-repository ppa:deafmute/interception
    sudo apt-get update
	sudo apt-get install interception-tools interception-tools-compat
elif test -x dnf; then
	sudo dnf copr enable fszymanski/interception-tools
	sudo dnf install interception-tools
else
	cd /tmp
	git clone https://gitlab.com/interception/linux/tools.git
	cd interception-tools
	cmake -B build -DCMAKE_BUILD_TYPE=Release
	cmake --build build
	sudo cmake --build build --target install
fi

cd /tmp
git clone https://gitlab.com/interception/linux/plugins/dual-function-keys
cd dual-function-keys
make
sudo make install
cd /tmp
rm -rf /tmp/dual-function-keys
sudo mkdir -p "/etc/interception/dual-function-keys/"
sudo cp "${directory}/caps.yaml"   "/etc/interception/dual-function-keys/"
sudo cp "${directory}/devmon.yaml" "/etc/interception/udevmon.d/"

if test -d /etc/sv/udevmon; then
	sudo ln -s /etc/sv/udevmon /var/service
fi
