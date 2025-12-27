# Home
PURE_HOME="$ZSH_HOME/pure"

# Download
if [ ! -d "$PURE_HOME" ]; then
    mkdir -p "$(dirname $PURE_HOME)"
    git clone https://github.com/sindresorhus/pure.git "$PURE_HOME"
fi

# Path
path+="$PURE_HOME"
export PATH

# Style
zstyle :prompt:pure:git:stash show yes

# Initialize
autoload -U promptinit && promptinit

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
