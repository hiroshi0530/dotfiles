# shellcheck shell=bash

# Keep system administration directories available.
path_prepend '/sbin'
path_prepend '/usr/sbin'

# Toolchains and package managers.
path_prepend '/opt/local/bin'
path_prepend '/opt/local/sbin'
path_prepend '/usr/local/texlive/2022/bin/universal-darwin'
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.nodebrew/current/bin"
path_prepend "$HOME/anaconda3/bin"
path_prepend "$HOME/.pyenv/bin"
path_prepend '/opt/poetry/bin'
path_append '/usr/local/go/bin'

# Go workspace bins.
path_prepend "$HOME/go/bin"
path_prepend "$HOME/go/ugo/bin"
path_prepend "$HOME/go/go_test/bin"

# User utilities.
path_append "$HOME/.pulumi/bin"
path_append '/opt/homebrew/share/git-core/contrib/diff-highlight'

export PATH
export MANPATH="/opt/local/man:${MANPATH:-}"

export PYENV_ROOT="$HOME/.pyenv"
export GOPATH="$HOME/go:$HOME/go/ugo:$HOME/go/go_test"

if command -v go >/dev/null 2>&1; then
  export GOROOT
  GOROOT="$(go env GOROOT)"
fi
