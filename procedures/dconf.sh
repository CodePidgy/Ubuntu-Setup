#!/bin/bash

desktop=false
desktop_work=false
laptop=false
work=false

if [[ "$1" == "--desktop" ]]; then
    desktop=true
fi

if [[ "$1" == "--desktop-work" ]]; then
    desktop=true
    desktop_work=true
fi

if [[ "$1" == "--laptop" ]]; then
    laptop=true
fi

if [[ "$1" == "--work" ]]; then
    work=true
fi

echo "[INFO] Loading dconf settings..."
dconf load / < dconf/system.ini
dconf load / < dconf/extensions.ini

if $desktop; then
    echo "[INFO] Loading desktop dconf settings..."
    dconf load / < dconf/desktop/system.ini
    dconf load / < dconf/desktop/extensions.ini
fi

if $desktop_work; then
    echo "[INFO] Loading desktop work dconf settings..."
    dconf load / < dconf/desktop/work/extensions.ini
fi

if $laptop; then
    echo "[INFO] Loading laptop dconf settings..."
    dconf load / < dconf/laptop/system.ini
    dconf load / < dconf/laptop/extensions.ini
fi

if $work; then
    echo "[INFO] Loading work dconf settings..."
    dconf load / < dconf/work/system.ini
    dconf load / < dconf/work/extensions.ini
fi

echo "[INFO] Done"
