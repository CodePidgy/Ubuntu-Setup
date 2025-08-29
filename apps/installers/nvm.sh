#!/bin/bash

# Get latest version
LATEST_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Create nvm directory
mkdir -p $HOME/.config/nvm

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$LATEST_VERSION/install.sh | bash

# Source nvm
source $HOME/.config/nvm/nvm.sh

# Install node
nvm install node
