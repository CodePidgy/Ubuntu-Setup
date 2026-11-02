#!/bin/bash

echo "[INFO] Installing Rider..."
sudo snap install --classic rider

echo "[INFO] Increasing inotify watch limit..."
sudo touch /etc/sysctl.d/idea.conf
sudo bash -c "echo 'fs.inotify.max_user_watches = 1000000' > /etc/sysctl.d/idea.conf"

echo "[INFO] Reloading sysctl..."
sudo sysctl -p --system

echo "[INFO] Done"
