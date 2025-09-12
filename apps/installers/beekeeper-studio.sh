#!/bin/bash

# Find the latest version
LATEST_VERSION=$(curl -s https://api.github.com/repos/beekeeper-studio/beekeeper-studio/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')

# Download
wget -P $HOME/Downloads https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v$LATEST_VERSION/beekeeper-studio_${LATEST_VERSION}_amd64.deb

# Install
sudo apt install -y $HOME/Downloads/beekeeper-studio_${LATEST_VERSION}_amd64.deb
