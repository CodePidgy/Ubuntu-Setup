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

# Install custom apps
while IFS= read -r app; do
    if [[ ${app:0:1} == "#" ]]; then
        continue
    fi

    eval apps/installers/$app.sh
done < "apps/custom.txt"
