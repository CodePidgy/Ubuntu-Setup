#!/bin/bash

# Set up Keychron Launcher keyboard access
sudo touch /etc/udev/rules.d/99-keychron-launcher.rules
echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0761", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"' | sudo tee -a /etc/udev/rules.d/99-vial.rules > /dev/null
sudo udevadm control --reload-rules
sudo udevadm trigger
