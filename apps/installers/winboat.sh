#!/bin/bash

echo "[INFO] Finding latest version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/TibixDev/winboat/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')
echo "[INFO] Winboat version: $LATEST_VERSION"

echo "[INFO] Downloading Winboat..."
wget -P $HOME/Downloads https://github.com/TibixDev/winboat/releases/download/v$LATEST_VERSION/winboat-${LATEST_VERSION}-amd64.deb

echo "[INFO] Installing Winboat..."
sudo apt install -y $HOME/Downloads/winboat-${LATEST_VERSION}-amd64.deb

echo "[INFO] Cleaning up..."
rm -f $HOME/Downloads/winboat-${LATEST_VERSION}-amd64.deb

echo "[INFO] Installing FreeRDP..."
sudo flatpak install -y flathub org.freerdp.FreeRDP

echo "[INFO] Loading iptables..."
echo -e "ip_tables\niptable_nat" | sudo tee /etc/modules-load.d/iptables.conf

echo "[INFO] Done"
