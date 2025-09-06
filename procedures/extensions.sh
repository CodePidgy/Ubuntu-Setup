#!/bin/bash

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

