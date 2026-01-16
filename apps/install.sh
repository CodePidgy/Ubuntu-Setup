#!/bin/bash

# Install snaps
while IFS="," read -r snap classic; do
    if [[ ${snap:0:1} == "#" ]]; then
        continue
    fi

    if [[ $classic == "true" ]]; then
        sudo snap install --classic $snap
    else
        sudo snap install $snap
    fi
done < "apps/snap.txt"

# Install apts
while IFS= read -r apt; do
    if [[ ${apt:0:1} == "#" ]]; then
        continue
    fi

    sudo apt install -y $apt
done < "apps/apt.txt"

# Install Flatpaks
while IFS= read -r flatpak; do
    if [[ ${flatpak:0:1} == "#" ]]; then
        continue
    fi

    sudo flatpak install -y $flatpak
done < "apps/flatpak.txt"
