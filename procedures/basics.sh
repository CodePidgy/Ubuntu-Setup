#!/bin/bash

# Dotfiles
stow -d dotfiles -t $HOME .

# Use local time instead of UTC
sudo timedatectl set-local-rtc 1
