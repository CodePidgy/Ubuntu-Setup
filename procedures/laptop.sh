#!/bin/bash

echo "[INFO] Enabling wake on USB..."
printf '%s\n' \
    'ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="3434", ATTR{idProduct}=="d027", ATTR{power/wakeup}="enabled"' \
    'ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c548", ATTR{power/wakeup}="enabled"' \
    | sudo tee /etc/udev/rules.d/10-wakeup.rules
sudo udevadm control --reload-rules

echo "[INFO] Done"
