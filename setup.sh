#!/usr/bin/env bash

set -euo pipefail

readonly DOTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if ! command -v brew &> /dev/null
then
    echo "##### Homebrew not found. Installing it. #####"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! [[ -d "$HOME/.oh-my-zsh" ]]
then
    echo "##### oh-my-zsh not found. Installing it. #####"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # remove default zshrc because it raises a conflict in stow"
    rm "$HOME/.zshrc"
fi

echo "##### Installing brew packages #####"
brew bundle --file "$DOTS/Brewfile"

npm install --global pure-prompt

echo "##### Restowing packages #####"
stow --restow \
  --dir="$DOTS" \
  --target="$HOME" \
  git nvim tmux zsh

# install pynvim (formerly python neovim) module
python3 -m pip install --upgrade pynvim

# install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


echo "##### Installing neovim plugins #####"
nvim --headless +PlugInstall +PlugUpdate +UpdateRemotePlugins +qall

