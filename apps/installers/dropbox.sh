#!/bin/bash

url="https://www.dropbox.com/download?dl=packages/ubuntu"

echo "[INFO] Finding latest Dropbox version..."
file=$(
    curl -fsLS $url |
    grep -oP '(?<!")dropbox_[0-9]*.[0-9]*.[0-9]*_amd64.deb' |
    tail -n 1
)

echo "[INFO] Downloading Dropbox..."
wget $url/$file -O $HOME/Downloads/$file
sudo dpkg -i $HOME/Downloads/$file
rm -f $HOME/Downloads/$file

echo "[INFO] Adding dropbox-ignore command..."
sudo ln -s $HOME/setup/scripts/dropbox-ignore.sh /usr/local/bin/dropbox-ignore
