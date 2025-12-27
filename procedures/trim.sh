#!/bin/bash

# Remove memtest from grub menu
sudo apt purge -y info memtest86+

# Remove default software app
sudo apt purge -y gnome-software-common gnome-software-plugin-flatpak gnome-software-plugin-snap
