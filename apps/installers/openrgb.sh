#!/bin/bash

echo "[INFO] Installing OpenRGB..."
flatpak install -y org.openrgb.OpenRGB

# Setup udev rules (https://openrgb.org/udev.html)
echo "[INFO] Setting up udev rules..."
sudo mkdir -p /etc/udev/rules.d
sudo sh -c 'flatpak run org.openrgb.OpenRGB --print-udev-rules > /etc/udev/rules.d/60-openrgb.rules'
sudo udevadm control --reload-rules
sudo udevadm trigger
