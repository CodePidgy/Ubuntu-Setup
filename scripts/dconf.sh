#!/bin/bash

laptop=false

if [[ "$1" == "--laptop" ]]; then
    laptop=true
fi

# Load dconf settings
dconf load / < dconf/system.ini
dconf load / < dconf/extensions.ini

# Load laptop-specific dconf settings
if $laptop; then
    dconf load / < dconf/laptop/system.ini
    dconf load / < dconf/laptop/extensions.ini
fi

