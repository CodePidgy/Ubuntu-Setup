# Home
ZINIT_HOME="$ZSH_HOME/zinit"

# Download
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source
source "${ZINIT_HOME}/zinit.zsh"

# Path
path+="$ZINIT_HOME"
export PATH
