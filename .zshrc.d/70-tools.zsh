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

# autojump
[[ -s "$HOME/.autojump/etc/profile.d/autojump.sh" ]] && source "$HOME/.autojump/etc/profile.d/autojump.sh"

# kubectl completion
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)
