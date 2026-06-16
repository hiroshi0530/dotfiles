# shellcheck shell=zsh
# GOPATH は Go のデフォルト ($HOME/go) に任せ、必要なら mise config.toml の [env] で上書きする
# GOROOT は mise activate が自動設定するため手動設定不要

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
[[ -d "$HOME/go/bin" ]]                         && path+=("$HOME/go/bin")  # go install 先
[[ -d "$HOME/.local/bin" ]]                     && path+=("$HOME/.local/bin")
[[ -d "$HOME/.pulumi/bin" ]]                    && path+=("$HOME/.pulumi/bin")
[[ -d "$HOME/.antigravity/antigravity/bin" ]]   && path+=("$HOME/.antigravity/antigravity/bin")
[[ -d "$HOME/win32yank/win32yank-x64" ]]        && path+=("$HOME/win32yank/win32yank-x64")

export PATH
[[ -d /opt/local/man ]] && export MANPATH="/opt/local/man:${MANPATH:-}"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
