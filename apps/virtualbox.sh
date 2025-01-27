#!/bin/bash

# Preset the PUEL license acceptance
echo virtualbox-ext-pack virtualbox-ext-pack/license select true | sudo debconf-set-selections

# Install VirtualBox
sudo apt install -y virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
