# shellcheck shell=zsh
export GOPATH="$HOME/go:$HOME/go/ugo:$HOME/go/go_test"
if command -v go >/dev/null 2>&1; then
  # shellcheck disable=SC2155
  export GOROOT="$(go env GOROOT 2>/dev/null)"
fi

# PATH (dedup via zsh typeset -U)
typeset -U path PATH
# shellcheck disable=SC2206
path=(
  /sbin
  /usr/sbin
  $path
)

[[ -d /opt/local/bin ]]                         && path+=(/opt/local/bin)
[[ -d /opt/local/sbin ]]                        && path+=(/opt/local/sbin)
[[ -d "$HOME/anaconda3/bin" ]]                  && path+=("$HOME/anaconda3/bin")
[[ -d "$HOME/go/bin" ]]                         && path+=("$HOME/go/bin")
[[ -d "$HOME/go/ugo/bin" ]]                     && path+=("$HOME/go/ugo/bin")
[[ -d "$HOME/go/go_test/bin" ]]                 && path+=("$HOME/go/go_test/bin")
[[ -d "$HOME/.local/bin" ]]                     && path+=("$HOME/.local/bin")
[[ -d /opt/poetry/bin ]]                        && path+=(/opt/poetry/bin)
[[ -d "$HOME/.pulumi/bin" ]]                    && path+=("$HOME/.pulumi/bin")
[[ -d "$HOME/.cargo/bin" ]]                     && path+=("$HOME/.cargo/bin")
[[ -d "$HOME/.antigravity/antigravity/bin" ]]   && path+=("$HOME/.antigravity/antigravity/bin")
[[ -d "$HOME/win32yank/win32yank-x64" ]]        && path+=("$HOME/win32yank/win32yank-x64")

export PATH
[[ -d /opt/local/man ]] && export MANPATH="/opt/local/man:${MANPATH:-}"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
