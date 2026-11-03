#!/bin/bash

echo "[INFO] Setting profile picture..."
sudo rm -rf /var/lib/AccountsService/icons/$USER
sudo busctl call org.freedesktop.Accounts /org/freedesktop/Accounts/User$(id -u) org.freedesktop.Accounts.User SetIconFile s "$(realpath images/profile.png)"

echo "[INFO] Copying wallpapers..."
mkdir -p $HOME/Pictures/Wallpapers
cp images/bg-light.svg $HOME/Pictures/Wallpapers/
cp images/bg-dark.svg $HOME/Pictures/Wallpapers/

echo "[INFO] Done"
