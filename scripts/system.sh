#!/bin/bash

# Update and upgrade everything
sudo apt update
sudo apt upgrade -y

# Remove unnecessary packages
sudo apt purge -y info memtest86+

# Remove leftover packages
sudo apt autoremove -y
