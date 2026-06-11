# nvm
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# deno
[[ -f "$HOME/.deno/env" ]] && . "$HOME/.deno/env"

# pyenv
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"

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

# mise
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

# kubectl completion
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)
