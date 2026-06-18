# shellcheck shell=zsh
# shellcheck disable=SC1090

# deno
[[ -f "$HOME/.deno/env" ]] && . "$HOME/.deno/env"

# mise (manages python, node, go, etc.)
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

# fzf
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# zoxide (modern autojump)
# z <dir> で移動、zi で fzf 対話選択
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
else
  # fallback: autojump
  [[ -s "$HOME/.autojump/etc/profile.d/autojump.sh" ]] && source "$HOME/.autojump/etc/profile.d/autojump.sh"
fi

# delta: git diff pager
# .gitconfig の [core] pager に delta を使うためのヘルパー設定
if command -v delta >/dev/null 2>&1; then
  export GIT_PAGER='delta'
fi

# kubectl completion
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)

# tmux-sessionizer: Ctrl+F でプロジェクト選択 → tmux session に接続
if command -v tmux-sessionizer >/dev/null 2>&1; then
  bindkey -s '^f' 'tmux-sessionizer\n'
fi

