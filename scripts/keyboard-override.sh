#!/bin/bash

RULES_FILE="/etc/udev/rules.d/99-keyboard-override.rules"
RULE='KERNEL=="event*", ATTRS{name}=="AT Translated Set 2 keyboard", ENV{LIBINPUT_IGNORE_DEVICE}="1"'

if [ "$1" == "--enable" ]; then
    if [ -f "$RULES_FILE" ]; then
        echo "[INFO] Nothing to do"
        exit 1
    fi

    echo "[INFO] Creating rule..."
    echo "$RULE" | sudo tee "$RULES_FILE" > /dev/null

    echo "[INFO] Done"
elif [ "$1" == "--disable" ]; then
    if [ ! -f "$RULES_FILE" ]; then
        echo "[INFO] Nothing to do"
        exit 1
    fi

    echo "[INFO] Removing rule..."
    sudo rm "$RULES_FILE"

    echo "[INFO] Done"
else
    echo "Usage: $0 --enable|--disable"
    echo "  --enable   Enable keyboard override"
    echo "  --disable  Disable keyboard override"
    exit 1
fi
