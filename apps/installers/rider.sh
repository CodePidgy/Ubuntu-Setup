#!/bin/bash

# Install Rider
sudo apt install -y rider --classic

# Create file
sudo touch /etc/sysctl.d/idea.conf

# Insert config
sudo bash -c "echo 'fs.inotify.max_user_watches = 1000000' > /etc/sysctl.d/idea.conf"

# Reload sysctl
sudo sysctl -p --system
