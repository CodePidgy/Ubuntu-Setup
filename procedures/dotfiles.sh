#!/bin/bash

echo "[INFO] Linking dotfiles..."
stow -d dotfiles -t $HOME .

echo "[INFO] Done"
