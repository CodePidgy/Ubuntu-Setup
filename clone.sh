#!/bin/bash

# Copy the firefox profile to the data folder
rm data/firefox.zip
(cd $HOME/snap/firefox/common/.mozilla && zip -9r - .) > data/firefox.zip
