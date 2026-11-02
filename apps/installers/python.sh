#!/bin/bash

# Install build dependencies (https://github.com/pyenv/pyenv/wiki#suggested-build-environment)
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev libzstd-dev

# Install Pyenv
curl -fsSL https://pyenv.run | bash

# Install Python
$HOME/.pyenv/bin/pyenv install $($HOME/.pyenv/bin/pyenv install -l | grep '^  3\.[0-9]*\.[0-9]*$' | tail -n 1)
$HOME/.pyenv/bin/pyenv global $($HOME/.pyenv/bin/pyenv versions | tail -n 1)

# Update pip
$HOME/.pyenv/shims/python -m pip install --upgrade pip

# Install pip tools
$HOME/.pyenv/shims/pip install pipx
$HOME/.pyenv/shims/pipx install black
$HOME/.pyenv/shims/pipx install poetry
$HOME/.local/bin/poetry config virtualenvs.in-project true
