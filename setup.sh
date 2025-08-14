#!/bin/bash

# Update and upgrade everything
sudo apt update
sudo apt upgrade -y

# Remove unnecessary packages
sudo apt purge -y info memtest86+

# Remove leftover packages
sudo apt autoremove -y

# Install cli tools
sudo apt install -y btop ca-certificates curl eza fzf rar stow tmux unrar unzip zsh
sudo rm -f /usr/share/applications/btop.desktop

# Set up git lfs
sudo apt install -y git-lfs
git lfs install

# Install some basic apps
sudo apt install -y alacritty dconf-editor gnome-shell-extension-manager gnome-tweaks

# Set default shell
chsh -s /usr/bin/zsh

# Install Flatpak
sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Load system dconf settings
dconf load / < dconf/system.ini

# Set profile picture
sudo rm -f /var/lib/AccountsService/icons/$USER
sudo cp images/profile.png /var/lib/AccountsService/icons/$USER
sudo sed -i "s/Icon=\/home\/aidan\/.face/Icon=\/var\/lib\/AccountsService\/icons\/aidan/" /var/lib/AccountsService/users/aidan

# Set wallpaper
mkdir $HOME/Pictures/Wallpapers
cp images/bg-light.svg $HOME/Pictures/Wallpapers/
cp images/bg-dark.svg $HOME/Pictures/Wallpapers/

# Dotfiles
stow -d dotfiles -t $HOME .

# Install GNOME extensions
extensions=(
    "https://extensions.gnome.org/extension/7/removable-drive-menu/"
    "https://extensions.gnome.org/extension/1160/dash-to-panel/"
    "https://extensions.gnome.org/extension/3193/blur-my-shell/"
    "https://extensions.gnome.org/extension/3210/compiz-windows-effect/"
    "https://extensions.gnome.org/extension/3740/compiz-alike-magic-lamp-effect/"
    "https://extensions.gnome.org/extension/3843/just-perfection/"
    "https://extensions.gnome.org/extension/4679/burn-my-windows/"
    "https://extensions.gnome.org/extension/6682/astra-monitor/"
)
for extension in ${extensions[@]}; do
    id=$(echo $extension | cut --delimiter=/ --field=5)
    url="https://extensions.gnome.org/extension-info/?pk=${id}"
    metadata=$(curl -s $url)
    uuid=$(echo $metadata | jq -r ".uuid" | tr -d "@")
    shell_version=$(gnome-shell --version | cut --delimiter=" " --field=3 | cut --delimiter=. --field=1)
    extension_version=$(echo $metadata | jq -r ".shell_version_map[\"${shell_version}\"].version")
    file_name="${uuid}.v${extension_version}.shell-extension.zip"

    wget -P $HOME/Downloads "https://extensions.gnome.org/extension-data/${file_name}"
    gnome-extensions install $HOME/Downloads/${file_name}
    rm -f $HOME/Downloads/${file_name}
done

# Load extension dconf settings
dconf load / < dconf/extensions.ini

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
