#!/bin/bash

# Remove memtest from grub menu
sudo apt purge -y info memtest86+

# Remove default software app
sudo apt purge -y gnome-software-common gnome-software-plugin-flatpak gnome-software-plugin-snap

# Remove other apps
sudo apt purge -y gnome-characters gnome-font-viewer yelp gnome-language-selector.desktop

# Remove other snaps
sudo snap remove --purge firmware-updater

# Hide shortcuts
echo Hidden=true | sudo tee -a /usr/share/applications/software-properties-drivers.desktop
