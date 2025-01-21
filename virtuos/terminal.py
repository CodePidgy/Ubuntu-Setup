# system imports --------------------------------------------------------------------------------- #
import subprocess


cli = [
    "btop",
    "curl",
    "eza",
    "fzf",
    "git",
    "neofetch",
    "net-tools",
    "rar",
    "stow",
    "unrar",
    "unzip",
    "zip",
    "zsh",
]

subprocess.call(["sudo", "apt", "install", "-y"] + cli)
