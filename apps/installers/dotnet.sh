#!/bin/bash

echo "[INFO] Adding .NET backports repository..."
sudo add-apt-repository -y ppa:dotnet/backports

echo "[INFO] Installing .NET SDKs and runtimes..."
sudo apt update
sudo apt install -y dotnet-sdk-10.0 dotnet-sdk-9.0 dotnet-sdk-8.0 aspnetcore-runtime-10.0 aspnetcore-runtime-9.0 aspnetcore-runtime-8.0

echo "[INFO] Done"
