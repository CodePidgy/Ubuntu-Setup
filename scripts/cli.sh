#!/bin/bash

# Install cli tools
sudo apt install -y btop ca-certificates curl eza fzf rar stow tmux unrar unzip zsh
sudo rm -f /usr/share/applications/btop.desktop

# Set default shell
chsh -s /usr/bin/zsh
