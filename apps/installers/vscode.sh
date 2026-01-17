#!/bin/bash

echo "[INFO] Installing Cursor..."
sudo snap install -y --classic code

echo "[INFO] Increasing inotify watch limit..."
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max_user_watches.conf

echo "[INFO] Done"
