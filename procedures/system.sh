#!/bin/bash

# Update and upgrade everything
sudo apt update
sudo apt upgrade -y

# Remove leftover packages
sudo apt autoremove -y

# Use local time instead of UTC
sudo timedatectl set-local-rtc 1

# Remove memtest from grub menu
sudo apt purge -y info memtest86+

# Make grub menu 1920x1080
sudo sed -i 's/GRUB_GFXMODE=640x480/GRUB_GFXMODE=1920x1080/' /etc/default/grub
sudo update-grub
