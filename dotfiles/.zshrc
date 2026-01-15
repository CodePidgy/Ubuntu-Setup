# Set base directories
ZSH_HOME="$HOME/.zsh"

# Modify path
path+="$HOME/.local/bin"
export PATH

# Load zinit
source "$ZSH_HOME/zinit.zsh"

# Load pure
source "$ZSH_HOME/pure.zsh"

# Add pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# Set up nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Key bindings
bindkey "^[[1;5C" autosuggest-accept
bindkey "^[[1;5A" history-search-backward
bindkey "^[[1;5B" history-search-forward

# Load completions
autoload -U compinit && compinit

# Suggestion history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":completion:*:git-checkout:*" sort false
zstyle ":fzf-tab:complete:cd:*" fzf-preview 'eza -1 --color=always $realpath'

# Aliases
alias c="clear"
alias gedit="gnome-text-editor"
alias iadd="z infodash-admin && npm run dev"
alias iadt="z infodash-admin && npm run test"
alias ls="ls -a --color"
alias nrd="npm run dev"
alias nrt="npm run test"

# Shell integrations
eval "$(pyenv init -)"
eval "$(zoxide init zsh)"

# Add fzf key bindings
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
