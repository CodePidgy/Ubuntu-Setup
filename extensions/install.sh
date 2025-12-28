#!/bin/bash

# Install GNOME extensions
while IFS= read -r extension; do
    if [[ ${extension:0:1} == "#" ]]; then
        continue
    fi

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
done < "extensions/gnome.txt"
