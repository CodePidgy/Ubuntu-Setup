#!/bin/bash

echo "[INFO] Removing default software app..."
sudo apt purge -y gnome-software-common gnome-software-plugin-flatpak

echo "[INFO] Removing other apps..."
sudo apt purge -y gnome-characters gnome-font-viewer

echo "[INFO] Removing other snaps..."
sudo snap remove --purge firmware-updater snap-store

echo "[INFO] Hiding shortcuts..."
echo Hidden=true | sudo tee -a /usr/share/applications/software-properties-drivers.desktop

echo "[INFO] Done"
