# silent the direnv output
export DIRENV_LOG_FORMAT=""

$HOME/.nix-profile/bin/fastfetch

# fzf defaut configs
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --style full"
export FZF_CTRL_T_OPTS="--style full --walker-skip .git,node_modules,target --preview 'bat --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

if [ -e /home/$USER/.nix-profile/etc/profile.d/nix.sh ]; then
  . /home/$USER/.nix-profile/etc/profile.d/nix.sh;
fi # added by Nix installer

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
  && ~/.tmux/plugins/tpm/bin/install_plugins
fi
setopt PROMPT_SUBST
# precmd() { print -n "\033]0;${PWD}\007" }

# Editor
EDITOR='nvim'

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
# alias jnv='NVIM_APPNAME=lazyvim-java nvim'
alias cl='clear'
alias lg='lazygit'
alias q='exit'








# --- CÓDIGO BÁSICO PARA PROMPT TRANSIENTE PERSONALIZADO ---
# !!! AVISO SÉRIO: ESTE CÓDIGO É UMA TENTATIVA BÁSICA E PODE NÃO FUNCIONAR CORRETAMENTE
#     OU PODE CONFLITAR COM TEMAS AVANÇADOS COMO O POWERLEVEL10K.
#     A CONFIGURAÇÃO DO TEMA É A FORMA RECOMENDADA. !!!

# Função que tenta limpar a linha do prompt anterior
function _attempt_transient_clear() {
  # Verifica se estamos numa sessão interativa com um terminal real
  # e se o ZLE (Zsh Line Editor) está ativo.
  if [[ $- == *i* ]] && [[ -n "$TERM" ]] && [[ -n "$ZLE_STATE" ]]; then
    # Usa sequências de controlo ANSI:
    # \e[1A : Move o cursor 1 linha para cima
    # \r    : Move o cursor para o início da linha atual (que agora é a linha acima)
    # \e[K  : Limpa a linha desde o cursor até ao fim

    # Nota: Se o teu prompt anterior ocupa mais de 1 linha, esta limpeza NÃO será suficiente.
    # Uma limpeza mais robusta seria \e[2K (limpar a linha inteira), mas ainda assim
    # precisarias de garantir que o cursor está no início da linha correta.

    # O '-n' impede que o 'echo' imprima uma nova linha no final.
    # O '-e' permite a interpretação das sequências de escape '\e'.
    echo -ne "\e[1A\r\e[K"

    # Após este comando, o Zsh imprimirá o novo prompt na linha onde estava
    # o prompt anterior (agora limpa).
  fi
}

# Adiciona a função à array de funções executadas antes de mostrar o prompt.
# É CRUCIAL que esta função seja adicionada *DEPOIS* de o teu tema (Powerlevel10k)
# ser source no .zshrc, mas pode precisar de ser antes das funções que o próprio
# tema adiciona a precmd_functions, o que cria o potencial conflito.
# Tenta colocar este bloco DEPOIS da linha onde o teu tema é source.
precmd_functions+=("_attempt_transient_clear")

# --- Fim do Código Básico Transiente ---
