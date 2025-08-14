#!/bin/bash

# Install Pyenv
curl -fsSL https://pyenv.run | bash
sudo apt install -y build-essential libbz2-dev libffi-dev liblzma-dev libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev tk-dev xz-utils zlib1g-dev

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
