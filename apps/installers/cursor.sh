#!/bin/bash

echo "[WAIT] Please download Cursor from https://cursor.com/download"
read -p "Press Enter to continue"

echo "[INFO] Finding .deb file..."
FILE=$(find $HOME/Downloads -type f -regextype posix-extended -regex ".*/cursor_[0-9]+\.[0-9]+\.[0-9]+_amd64\.deb" | head -n 1)

if [[ -z "$FILE" ]]; then
    echo "[ERROR] No matching .deb file found in $HOME/Downloads"
    exit 1
fi

echo "[INFO] Installing Cursor..."
sudo apt install -y $FILE

echo "[INFO] Increasing inotify watch limit..."
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
sudo bash -c "echo '# Increase inotify watch limit for Cursor' >> /etc/sysctl.conf"
sudo bash -c "echo 'fs.inotify.max_user_watches = 524288' >> /etc/sysctl.conf"
sudo sysctl -p --system

echo "[INFO] Done"
