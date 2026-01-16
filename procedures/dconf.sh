#!/bin/bash

desktop=false
laptop=false
work=false
work_home=false
work_office=false

if [[ "$1" == "--desktop" ]]; then
    desktop=true
fi

if [[ "$1" == "--laptop" ]]; then
    laptop=true
fi

if [[ "$1" == "--work" ]]; then
    work=true
fi

if [[ "$1" == "--work-home" ]]; then
    work=true
    work_home=true
fi

if [[ "$1" == "--work-office" ]]; then
    work=true
    work_office=true
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

# Load work-specific dconf settings
if $work; then
    dconf load / < dconf/work/system.ini
    dconf load / < dconf/work/extensions.ini
fi

if $work_home; then
    dconf load / < dconf/work/home/system.ini
    dconf load / < dconf/work/home/extensions.ini
fi

if $work_office; then
    dconf load / < dconf/work/office/system.ini
    dconf load / < dconf/work/office/extensions.ini
fi
