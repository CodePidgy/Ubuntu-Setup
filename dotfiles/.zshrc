# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set directory for zinit and its plugins
ZINIT_HOME="${HOME/.local/share/}/zinit/zinit.git"

# Download zinit if not installed yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Modify path
path+="$HOME/.local/bin"
path+="$HOME/.platformio/penv/bin"

export PATH

# Add pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# Set up nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Add Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Key bindings
bindkey "^[[1;5C" autosuggest-accept
bindkey "^[[1;5A" history-search-backward
bindkey "^[[1;5B" history-search-forward

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
alias gedit="gnome-text-editor"
alias ls="ls -a --color"

# Shell integrations
eval "$(pyenv init -)"
#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Add fzf key bindings
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

if [ -z "$TMUX" ]; then
  tmux attach-session -t default &> /dev/null || tmux new-session -s default
fi
