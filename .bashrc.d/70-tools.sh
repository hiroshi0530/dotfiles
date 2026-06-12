# shellcheck shell=bash

# make less more friendly for non-text input files
if [ -x /usr/bin/lesspipe ]; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

if command -v brew >/dev/null 2>&1; then
  autojump_sh="$(brew --prefix)/etc/autojump.sh"
  # shellcheck source=/dev/null
  [ -s "$autojump_sh" ] && . "$autojump_sh"
fi

if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" activate bash)"
fi

[ -f "$HOME/.fzf.bash" ] && . "$HOME/.fzf.bash"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

if command -v trash-put >/dev/null 2>&1; then
  alias rm='trash-put'
fi

# Set DISPLAY only on Linux (not macOS or WSL2 which manages it separately).
if [[ "$(uname -s)" == "Linux" ]] && [[ -z "${WAYLAND_DISPLAY:-}" ]] && [[ -z "${DISPLAY:-}" ]]; then
  export DISPLAY=':0'
fi
