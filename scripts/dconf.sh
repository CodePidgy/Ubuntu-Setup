#!/bin/bash

# Load system dconf settings
dconf load / < dconf/system.ini

# Load extension dconf settings
dconf load / < dconf/extensions.ini

