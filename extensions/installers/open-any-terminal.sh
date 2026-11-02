#!/bin/bash

echo "[INFO] Finding latest version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/Stunkymonkey/nautilus-open-any-terminal/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

echo "[INFO] Downloading extension..."
wget -P $HOME/Downloads https://github.com/Stunkymonkey/nautilus-open-any-terminal/releases/download/$LATEST_VERSION/nautilus-extension-any-terminal_${LATEST_VERSION}-1_all.deb

echo "[INFO] Installing extension..."
sudo apt install -y $HOME/Downloads/nautilus-extension-any-terminal_${LATEST_VERSION}-1_all.deb

echo "[INFO] Cleaning up..."
rm -f $HOME/Downloads/nautilus-extension-any-terminal_${LATEST_VERSION}-1_all.deb

echo "[INFO] Done"
