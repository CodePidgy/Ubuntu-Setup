#!/bin/bash

# Remove memtest from grub menu
sudo apt purge -y info memtest86+

# Remove default software app
sudo apt purge -y gnome-software-common gnome-software-plugin-flatpak

# Remove other apps
sudo apt purge -y gnome-characters gnome-font-viewer

# Remove other snaps
sudo snap remove --purge firmware-updater snap-store

# Hide shortcuts
echo Hidden=true | sudo tee -a /usr/share/applications/software-properties-drivers.desktop
