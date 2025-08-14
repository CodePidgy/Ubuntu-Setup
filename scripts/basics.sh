#!/bin/bash

# Dotfiles
stow -d dotfiles -t $HOME .

# Install some basic apps
sudo apt install -y alacritty dconf-editor gnome-shell-extension-manager gnome-tweaks
