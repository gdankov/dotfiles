# Path to oh-my-zsh installation.
export ZSH=/Users/i336730/.oh-my-zsh

ZSH_THEME="spaceship"

plugins=(
  z
  fz
)

source $ZSH/oh-my-zsh.sh

# Use bluemix cluster
export KUBECONFIG=$HOME/.bluemix/plugins/container-service/clusters/alfheim/kube-config-lon02-alfheim.yml

# Dotfiles
alias dotcfg='/usr/local/bin/git --git-dir=$HOME/.dotcfg/ --work-tree=$HOME'
dotcfg config --local status.showUntrackedFiles no
dotcfg update-index --assume-unchanged $HOME/LICENSE
dotcfg update-index --assume-unchanged $HOME/README.md


# Set language environment
export LANG=en_US.UTF-8

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Spaceship theme config
export SPACESHIP_DIR_TRUNC=10
export SPACESHIP_DIR_TRUNC_REPO=false
export SPACESHIP_EXIT_CODE_SHOW=true

# Zsh-autocomplete
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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

# Editors
export GIT_EDITOR="vim"
export KUBE_EDITOR="vim"

# Keys
bindkey '\C-b' beginning-of-line

# Hub
eval "$(hub alias -s)"
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

source $HOME/.funcs
source $HOME/.aliases
