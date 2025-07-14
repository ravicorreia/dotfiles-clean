export DIRENV_LOG_FORMAT=""

# Editor
EDITOR='nvim'

# Add ~/.local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Add ~/.cargo/bin to PATH added that due to eza's cargo build installation.
export PATH="$HOME/.cargo/bin:$PATH"

# $HOME/.nix-profile/bin/fastfetch

# fzf defaut configs
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --style full"
export FZF_CTRL_T_OPTS="--style full --walker-skip .git,node_modules,target --preview 'bat --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Nix no longer required with Fedora
# if [ -e /home/$USER/.nix-profile/etc/profile.d/nix.sh ]; then
#   . /home/$USER/.nix-profile/etc/profile.d/nix.sh;
# fi # added by Nix installer

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
  && ~/.tmux/plugins/tpm/bin/install_plugins
fi

# TODO need to find out what are those to lines for..
setopt PROMPT_SUBST
precmd() { print -n "\033]0;${PWD}\007" }

# Zinit
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"
# Load Completions
autoload -U compinit && compinit
# Completion Styling
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview "ls -a --color $realpath"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "eza --long --tree --level=1 --all --icons --group-directories-last --git-repos --git --no-permissions --no-filesize --no-user --no-time $realpath"

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Add in Aloxaf fzf-tab plugin
zinit ice depth=1; zinit light Aloxaf/fzf-tab
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions

# Zinit pede pra colocar isso pra ajeitar ordem de carregamento dos plugins \_('-')_/
zinit cdreplay -q

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# Keybindigns
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# Enable vi mode
bindkey -v
# Set jk as escape
bindkey -M viins 'kj' vi-cmd-mode

alias l='eza --long --tree --level=1 --all --icons --group-directories-last --git-repos --git --no-permissions --no-filesize --no-user --no-time'
alias ~='cd ~'
alias inv='nvim $(fzf --style full -m --preview="bat --color=always {}")'
alias nv='nvim'
alias cl='clear'
alias lg='lazygit'
alias q='exit'
alias minikctl="minikube kubectl"

# nvm requires
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Load Angular CLI autocompletion.
source <(ng completion script)
