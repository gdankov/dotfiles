# Path to oh-my-zsh installation.
export ZSH=/Users/i336730/.oh-my-zsh

ZSH_THEME="spaceship"

plugins=(
  git
  z
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias gits="git status"


# Kubernetes aliases
alias k='kubectl'

alias kg='kubectl get'
alias kga='kubectl get all'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgst='kubectl get statefulsets'
alias kgse='kubectl get services'
alias kgj='kubectl get jobs'

alias kdes='kubectl describe'
alias kdesp='kubectl describe pod'
alias kdesd='kubectl describe deployment'
alias kdesst='kubectl describe statefulset'
alias kdesse='kubectl describe service'
alias kdesj='kubectl describe job'

alias kdel='kubectl delete'
alias kdelp='kubectl delete pod'
alias kdeld='kubectl delete deployment'
alias kdelst='kubectl delete statefulset'
alias kdelse='kubectl delete service'
alias kdelj='kubectl delete job'

alias ka='kubectl apply -f'
alias klo='kubectl logs -f'
alias kex='kubectl exec -it'

# Use bluemix cluster
export KUBECONFIG=$HOME/.bluemix/plugins/container-service/clusters/alfheim/kube-config-lon02-alfheim.yml

# Dotfiles
alias dotcfg='$(which git) --git-dir=$HOME/.dotcfg/ --work-tree=$HOME'
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


#    ______                 __  _
#   / ____/_  ______  _____/ /_(_)___  ____  _____
#  / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
# / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  )
#/_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/

# TMUX + TMATE = <3
readonly TMATE_PAIR_NAME="$(whoami)-pair"
readonly TMATE_SOCKET_LOCATION="/tmp/tmate-pair.sock"
readonly TMATE_TMUX_SESSION="/tmp/tmate-tmux-session"

tmate-url() {
    local url=""
    while [ -z "$url" ]; do
        url="$(tmate -S $TMATE_SOCKET_LOCATION display -p '#{tmate_ssh}')"
    done
    echo "$url" | tr -d '\n' | pbcopy
    echo "Copied tmate url for $TMATE_PAIR_NAME:"
    echo "$url"
}

# Start a tmate session by attaching to an existing tmux session
mate() {
    if [ ! -e "$TMATE_SOCKET_LOCATION" ]; then
      tmate -S "$TMATE_SOCKET_LOCATION" \
          -f "$HOME/.tmate.conf" new-session \
          -d -s "$TMATE_PAIR_NAME"

      tmate-url

      if [ -n "$1" ]; then
        echo $1 > $TMATE_TMUX_SESSION
        tmate -S "$TMATE_SOCKET_LOCATION" send \
            -t "$TMATE_PAIR_NAME" \
            "TMUX='' tmux attach-session -t $1" ENTER
      fi
    fi
    tmate -S "$TMATE_SOCKET_LOCATION" attach-session \
        -t "$TMATE_PAIR_NAME"
}

# Close the tmate session
f-off() {
    if [ -e "$TMATE_SOCKET_LOCATION" ]; then
      rm -f $TMATE_TMUX_SESSION
      tmate -S "$TMATE_SOCKET_LOCATION" kill-session -t "$TMATE_PAIR_NAME"

      echo "Killed session $TMATE_PAIR_NAME"
    else
      echo "Session already killed"
    fi
}

# Kubernetes

# set namespace
knam() {
    local ctx=$(kubectl config current-context)
    local ns="$1"

    ns=$(kubectl get namespace $1 --no-headers --output=go-template={{.metadata.name}} 2>/dev/null)

    if [ -z "${ns}" ]; then
        echo "Namespace (${1}) not found!"
        exit 1
    fi

    kubectl config set-context ${ctx} --namespace="${ns}"
}


# General

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
