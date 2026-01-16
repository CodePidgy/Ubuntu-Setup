#!/bin/bash

echo "[INFO] Finding latest nvm version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

echo "[INFO] Creating nvm directory..."
mkdir -p $HOME/.config/nvm

echo "[INFO] Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$LATEST_VERSION/install.sh | bash
source $HOME/.config/nvm/nvm.sh

echo "[INFO] Installing latest Node.js..."
nvm install node

echo "[INFO] Done"
