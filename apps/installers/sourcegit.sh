#!/bin/bash

echo "[INFO] Adding repository..."
curl https://codeberg.org/api/packages/yataro/debian/repository.key | sudo tee /etc/apt/keyrings/sourcegit.asc
echo "deb [signed-by=/etc/apt/keyrings/sourcegit.asc, arch=amd64,arm64] https://codeberg.org/api/packages/yataro/debian generic main" | sudo tee /etc/apt/sources.list.d/sourcegit.list
sudo apt update

echo "[INFO] Installing SourceGit..."
sudo apt install sourcegit

echo "[INFO] Finding latest Git Credential Manager version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')

echo "[INFO] Downloading Git Credential Manager..."
wget -P $HOME/Downloads https://github.com/git-ecosystem/git-credential-manager/releases/download/v$LATEST_VERSION/gcm-linux-x64-${LATEST_VERSION}.deb

echo "[INFO] Installing Git Credential Manager..."
sudo apt install -y $HOME/Downloads/gcm-linux-x64-${LATEST_VERSION}.deb

echo "[INFO] Setting up Git Credential Manager..."
git config --global credential.credentialStore gpg

echo "[INFO] Installing pass..."
sudo apt install -y pass

echo "[INFO] Done"

# Manual setup
# - Copy password for email address
# > gpg --gen-key
# - Copy the ID for the key
# > pass init <ID>
# > git-credential-manager configure
