#!/bin/bash

echo "[INFO] Finding latest SourceGit version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/sourcegit-scm/sourcegit/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')

echo "[INFO] Downloading SourceGit..."
wget -P $HOME/Downloads https://github.com/sourcegit-scm/sourcegit/releases/download/v$LATEST_VERSION/sourcegit_${LATEST_VERSION}-1_amd64.deb

echo "[INFO] Installing SourceGit..."
sudo apt install -y $HOME/Downloads/sourcegit_${LATEST_VERSION}-1_amd64.deb

echo "[INFO] Finding latest Git Credential Manager version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')

echo "[INFO] Downloading Git Credential Manager..."
wget -P $HOME/Downloads https://github.com/git-ecosystem/git-credential-manager/releases/download/v$LATEST_VERSION/gcm-linux_amd64.${LATEST_VERSION}.deb

echo "[INFO] Installing Git Credential Manager..."
sudo apt install -y $HOME/Downloads/gcm-linux_amd64.${LATEST_VERSION}.deb

echo "[INFO] Setting up Git Credential Manager..."
git config --global credential.credentialStore gpg

echo "[INFO] Installing pass..."
sudo apt install -y pass

# Manual setup
# - Copy password for email address
# > gpg --gen-key
# - Copy the ID for the key
# > pass init <ID>
# > git-credential-manager configure
