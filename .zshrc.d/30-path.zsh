# shellcheck shell=zsh
# GOPATH は mise config.toml の [env] で管理 (~/go)
# GOROOT は mise activate が自動設定するため手動設定不要
export GOPATH="$HOME/go"

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
# anaconda3: mise Python と競合するため削除
# [[ -d "$HOME/anaconda3/bin" ]] && path+=("$HOME/anaconda3/bin")
[[ -d "$HOME/go/bin" ]]                         && path+=("$HOME/go/bin")  # go install 先
[[ -d "$HOME/go/ugo/bin" ]]                     && path+=("$HOME/go/ugo/bin")
[[ -d "$HOME/go/go_test/bin" ]]                 && path+=("$HOME/go/go_test/bin")
[[ -d "$HOME/.local/bin" ]]                     && path+=("$HOME/.local/bin")
# poetry: mise 管理に移行したため削除
# [[ -d /opt/poetry/bin ]] && path+=(/opt/poetry/bin)
[[ -d "$HOME/.pulumi/bin" ]]                    && path+=("$HOME/.pulumi/bin")
# cargo/bin: mise rust 管理に移行したため削除
# [[ -d "$HOME/.cargo/bin" ]] && path+=("$HOME/.cargo/bin")
[[ -d "$HOME/.antigravity/antigravity/bin" ]]   && path+=("$HOME/.antigravity/antigravity/bin")
[[ -d "$HOME/win32yank/win32yank-x64" ]]        && path+=("$HOME/win32yank/win32yank-x64")

export PATH
[[ -d /opt/local/man ]] && export MANPATH="/opt/local/man:${MANPATH:-}"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
