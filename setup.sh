#!/usr/bin/env bash

set -euo pipefail

readonly DOTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


stow --restow \
  --dir="$DOTS" \
  --target="$HOME" \
  git nvim tmux zsh
