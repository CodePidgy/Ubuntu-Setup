#!/bin/bash

# Find the latest version
LATEST_VERSION=$(curl -s https://api.github.com/repos/sourcegit-scm/sourcegit/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')

# Download SourceGit
wget -P $HOME/Downloads https://github.com/sourcegit-scm/sourcegit/releases/download/v$LATEST_VERSION/sourcegit_${LATEST_VERSION}-1_amd64.deb

# Install SourceGit
sudo apt install -y $HOME/Downloads/sourcegit_${LATEST_VERSION}-1_amd64.deb

# Download Git Credential Manager
LATEST_VERSION=$(curl -s https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')

# Download Git Credential Manager
wget -P $HOME/Downloads https://github.com/git-ecosystem/git-credential-manager/releases/download/v$LATEST_VERSION/gcm-linux_amd64.${LATEST_VERSION}.deb

# Install Git Credential Manager
sudo apt install -y $HOME/Downloads/gcm-linux_amd64.${LATEST_VERSION}.deb

# Setup Git Credential Manager
git config --global credential.credentialStore gpg
git-credential-manager configure

# Prompt for email addresses
echo "Enter email addresses (one per line, press Enter twice when done):"
emails=()
while IFS= read -r line; do
    if [[ -z "$line" ]]; then
        break
    fi
    emails+=("$line")
done

# Configure Git Credential Manager for each email
for email in "${emails[@]}"; do
    read -p "Press Enter to continue with $email (or Ctrl+C to exit)..."

    gpg --quick-generate-key "Aidan Venter <$email>" ed25519

    gpg_id=$(gpg --list-keys --with-colons --with-fingerprint | awk -F: '/^fpr:/ { print $10 }' | tail -1)
    pass init $gpg_id
done

