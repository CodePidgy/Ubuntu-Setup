#!/bin/bash

# Update and upgrade everything
sudo apt update
sudo apt upgrade -y

# Remove leftover packages
sudo apt autoremove -y

# Use local time instead of UTC
sudo timedatectl set-local-rtc 1
