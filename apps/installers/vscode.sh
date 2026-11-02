#!/bin/bash

echo "[INFO] Installing VSCode..."
sudo snap install --classic code

echo "[INFO] Increasing inotify watch limit..."
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max_user_watches.conf

echo "[INFO] Done"
