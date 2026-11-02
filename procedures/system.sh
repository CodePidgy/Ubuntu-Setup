#!/bin/bash

echo "[INFO] Updating packages..."
sudo apt update
sudo apt upgrade -y

echo "[INFO] Removing leftover packages..."
sudo apt autoremove -y

echo "[INFO] Using local time instead of UTC..."
sudo timedatectl set-local-rtc 1

echo "[INFO] Removing memtest from grub menu..."
sudo apt purge -y info memtest86+

echo "[INFO] Setting grub menu to 1920x1080..."
sudo sed -i 's/GRUB_GFXMODE=640x480/GRUB_GFXMODE=1920x1080/' /etc/default/grub
sudo update-grub

echo "[INFO] Done"
