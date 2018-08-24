# Path to oh-my-zsh installation.
export ZSH=/Users/i336730/.oh-my-zsh

ZSH_THEME="spaceship"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

plugins=(
  git
  z
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias gits="git status"

# Dotfiles
alias dotcfg='$(which git) --git-dir=$HOME/.dotcfg/ --work-tree=$HOME'
dotcfg config --local status.showUntrackedFiles no
dotcfg update-index --assume-unchanged LICENSE
dotcfg update-index --assume-unchanged README.md


# Set language environment
export LANG=en_US.UTF-8

export KUBE_EDITOR="vim"

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

### Added by IBM Cloud CLI
source /usr/local/Bluemix/bx/zsh_autocomplete

# For tmux and airline
export TERM=xterm-256color

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

# Ruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

export GIT_EDITOR="vim"



# Custom functions
search-and-replace() {
    local keyword=${1?Keyword not present}
    local replacement=${2?Replacement not present}

    rg -l $keyword -t go -g '!vendor/' | xargs -L 1 -o vim -c "%s/$keyword\C/$replacement/gc"
}


set-dev-cf-org() {
    local org="$1"
    cf create-org $org
    cf target -o $org
    cf create-space dev
    cf target -s dev
}
