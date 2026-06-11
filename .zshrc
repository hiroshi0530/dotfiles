# shellcheck shell=zsh
# shellcheck disable=SC1090
# Load zshrc modules
_zshrc_d="$HOME/.zshrc.d"
for _zshrc_f in \
  00-options.zsh \
  10-env.zsh \
  20-history.zsh \
  30-path.zsh \
  40-less.zsh \
  50-completion.zsh \
  60-prompt.zsh \
  70-tools.zsh; do
  [[ -f "$_zshrc_d/$_zshrc_f" ]] && source "$_zshrc_d/$_zshrc_f"
done
unset _zshrc_d _zshrc_f

# Optional user files
[[ -f ~/.zsh_aliases ]]   && source ~/.zsh_aliases
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions
[[ -f ~/.zsh_private ]]   && source ~/.zsh_private
[[ -f ~/.zsh_private_aliases ]] && source ~/.zsh_private_aliases
