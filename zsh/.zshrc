# Path to oh-my-zsh installation.
export ZSH=/Users/i336730/.oh-my-zsh

ZSH_THEME=""

# Set Pure ZSH theme
autoload -U promptinit; promptinit
prompt pure

# Show non-zero exit status
precmd_pipestatus() {
    local exit_status="${(j.|.)pipestatus}"
    if [[ $exit_status = 0 ]]; then
           return 0
    fi
    echo -n ${exit_status}' '
}

# Show current kubectl cluster and namespace
precmd_kubectl_context() {
    if ! context="$(kubectl config current-context 2>/dev/null)"; then
        ZSH_KUBECTL_PROMPT=""
        return 1
    fi
    ns="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}")"

    kube_symbol='k8s'
    kubectl_prompt="${kube_symbol} | ${context}:${ns}"

    RPROMPT='%{$fg[blue]%}«${kubectl_prompt}»%{$reset_color%}'
}
add-zsh-hook precmd precmd_kubectl_context

# Disable Pure terminal title updates
prompt_pure_set_title() {}

# Show exit code of last command as a separate prompt character
PROMPT='%(?.%F{magenta}.%F{red}❯%F{magenta})❯%f '
# Show exit status before prompt
PROMPT='%F{red}$(precmd_pipestatus)'$PROMPT

# add-zsh-hook precmd precmd_pipestatus

plugins=(
  z
  fz
)

source $ZSH/oh-my-zsh.sh

# Set language environment
export LANG=en_US.UTF-8

# Kubernetes autocompletiom
source <(kubectl completion zsh)

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=auto

# Spaceship theme config
export SPACESHIP_DIR_TRUNC=10
export SPACESHIP_DIR_TRUNC_REPO=false
export SPACESHIP_EXIT_CODE_SHOW=true

# Zsh-autocomplete
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Use ctrl-f to accept the current suggestion
bindkey '^f' autosuggest-accept

# Direnv
eval "$(direnv hook zsh)"

# Git duet
export GIT_DUET_ROTATE_AUTHOR=1
export GIT_DUET_GLOBAL=true

# Ruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 15% --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/"'

# Neovim master race
alias vim=nvim
# Lazy people master race
alias v=vim
alias vrc="vim ~/.vimrc"
alias zrc="vim ~/.zshrc"
alias trc="vim ~/.tmux.conf"

# Editors
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export KUBE_EDITOR="nvim"

# Keys
bindkey '\C-b' beginning-of-line

# Hub
eval "$(hub alias -s)"
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

# Bat 🦇
alias cat='bat --paging=never --style=plain'
export BAT_THEME="TwoDark" 


# Make man colourful
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# virtualeenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

source $HOME/.funcs
source $HOME/.aliases

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# zsh-bd
. $HOME/.zsh/plugins/bd/bd.zsh
