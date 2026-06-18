# shellcheck shell=zsh
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

# atuin: enhanced shell history
# https://docs.atuin.sh/
# Ctrl-R で fuzzy 検索、通常の上下矢印はそのまま使える
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi
