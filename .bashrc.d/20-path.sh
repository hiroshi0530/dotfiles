# shellcheck shell=bash

# Keep system administration directories available.
[ -d '/sbin' ]      && path_prepend '/sbin'
[ -d '/usr/sbin' ]  && path_prepend '/usr/sbin'

# Toolchains and package managers.
[ -d '/opt/local/bin' ]                                        && path_prepend '/opt/local/bin'
[ -d '/opt/local/sbin' ]                                       && path_prepend '/opt/local/sbin'
[ -d '/usr/local/texlive/2022/bin/universal-darwin' ]          && path_prepend '/usr/local/texlive/2022/bin/universal-darwin'
[ -d "$HOME/.local/bin" ]                                      && path_prepend "$HOME/.local/bin"
[ -d '/usr/local/go/bin' ]                                     && path_append  '/usr/local/go/bin'

# Go workspace bins.
[ -d "$HOME/go/bin" ]          && path_prepend "$HOME/go/bin"
[ -d "$HOME/go/ugo/bin" ]      && path_prepend "$HOME/go/ugo/bin"
[ -d "$HOME/go/go_test/bin" ]  && path_prepend "$HOME/go/go_test/bin"

# User utilities.
[ -d "$HOME/.pulumi/bin" ]                                              && path_append "$HOME/.pulumi/bin"
[ -d '/opt/homebrew/share/git-core/contrib/diff-highlight' ]            && path_append '/opt/homebrew/share/git-core/contrib/diff-highlight'

export PATH
export MANPATH="/opt/local/man:${MANPATH:-}"

# GOPATH: mise の [env] で管理 (~/go)
export GOPATH="$HOME/go"
# GOROOT は mise activate が自動設定するため手動設定不要
