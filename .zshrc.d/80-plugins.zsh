# shellcheck shell=zsh
# zsh plugin management via sheldon
# https://sheldon.cli.rs/

if command -v sheldon >/dev/null 2>&1; then
  eval "$(sheldon source)"

  # zsh-history-substring-search: 上下矢印で部分一致履歴検索
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down

  # zsh-autosuggestions: Tab で補完候補を確定
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  bindkey '^ ' autosuggest-accept
fi
