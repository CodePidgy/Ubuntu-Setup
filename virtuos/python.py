# system imports --------------------------------------------------------------------------------- #
import os

# local imports ---------------------------------------------------------------------------------- #
from utils import print_subheading

# script ----------------------------------------------------------------------------------------- #
print_subheading("Pyenv")
os.system("curl -fsSL https://pyenv.run | bash")

print("Loading Pyenv...", end="")
os.system("source ~/.zshrc")
print("\tDone")

print_subheading("Build Dependencies")
os.system(
    "sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev "
    "libsqlite3-dev curl git libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev "
    "liblzma-dev"
)

print_subheading("Python")
os.system(
    "$HOME/.pyenv/bin/pyenv install $($HOME/.pyenv/bin/pyenv install -l | "
    r"grep '^  3\.[0-9]*\.[0-9]+$' | tail -n 1)"
)

print("Setting Python version...", end="")
os.system("$HOME/.pyenv/bin/pyenv global $($HOME/.pyenv/bin/pyenv versions | tail -n 1)")
print("\tDone")

print_subheading("Pip")
os.system("pip install pipx")

print_subheading("Pip Tools")
os.system("pipx install black")
os.system("pipx install poetry")
os.system("poetry config virtualenvs.in-project true")
