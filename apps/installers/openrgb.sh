#!/bin/bash

# Install
flatpak install -y org.openrgb.OpenRGB

# Setup udev rules (https://openrgb.org/udev)
wget https://openrgb.org/releases/release_0.9/60-openrgb.rules
sudo mv 60-openrgb.rules /usr/lib/udev/rules.d
sudo udevadm control --reload-rules
sudo udevadm trigger
