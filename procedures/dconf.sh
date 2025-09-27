#!/bin/bash

desktop=false
laptop=false

if [[ "$1" == "--desktop" ]]; then
    desktop=true
fi

if [[ "$1" == "--laptop" ]]; then
    laptop=true
fi

# Load dconf settings
dconf load / < dconf/system.ini
dconf load / < dconf/extensions.ini

# Load desktop-specific dconf settings
if $desktop; then
    dconf load / < dconf/desktop/system.ini
    dconf load / < dconf/desktop/extensions.ini
fi

# Load laptop-specific dconf settings
if $laptop; then
    dconf load / < dconf/laptop/system.ini
    dconf load / < dconf/laptop/extensions.ini
fi

