#!/bin/bash

# Disable cdrom repo
sed -i '/deb cdrom:/ s/^/#/' /etc/apt/sources.list

# Updates
apt update && apt upgrade -y

# Minimal Gnome
apt install gnome-core --no-install-recommends -y

# Basic tools and Firefox
apt install git wget gpg software-properties-common apt-transport-https ca-certificates firefox-esr -y
apt --fix-broken install #maybe

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb

# Edge https://www.linuxcapable.com/how-to-install-microsoft-edge-on-debian-linux/
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /usr/share/keyrings/microsoft-edge.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | tee /etc/apt/sources.list.d/microsoft-edge.list
apt update
apt install microsoft-edge-stable -y

# Powershell https://medium.com/@nothanjack/powershellget-started-with-powershell-on-debian-12-terminal-installation-guide-97ea6371e4c1
wget -q https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
apt update
apt install powershell -y

# VSCode https://linuxiac.com/how-to-install-vs-code-on-debian-12/
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
apt update
apt install code -y

# Powershell
apt install powershell -y

# Flatpak
apt install flatpak -y
apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
chmod +x get-docker.sh
. get-docker.sh
rm get-docker.sh
