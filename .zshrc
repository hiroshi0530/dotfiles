setopt glob
setopt extended_glob
    setopt prompt_subst
setopt no_nomatch
setopt inc_append_history
setopt hist_verify
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt vi

# Prompt
function short_pwd {
  local full_path="$PWD"
  local shortened_path=""
  local part
  local last_part

  if [[ $full_path == $HOME* ]]; then
    shortened_path="~"
    full_path=${full_path#$HOME}
  fi

  local path_parts=(${(s:/:)full_path})

  if [[ ${#path_parts[@]} -le 0 ]]; then
    [[ -n "$full_path" ]] && shortened_path+="$full_path"
    echo "$shortened_path"
    return
  fi

  last_part=${path_parts[-1]}

  for part in ${path_parts[@]:0:-1}; do
    if [[ -n "$part" ]]; then
      if [[ -z "$shortened_path" ]]; then
        shortened_path+="/$part"
      else
        shortened_path+="/${part:0:3}"
      fi
    fi
  done

  shortened_path+="/$last_part"
  echo "$shortened_path"
}
export PS1='$(short_pwd) $ '

# Base env
export EDITOR='nvim'
export PAGER='less'
umask 022

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

# Completion
autoload -Uz compinit
compinit -u
compdef _directories cd
compdef _command man command type which
compdef _setopt setopt
compdef _shopt shopt
compdef _aliases unalias
compdef _builtin builtin
compdef _bindkey bind
compdef _aws_completer aws

# TTY behavior
TRAPWINCH() {
  [[ -t 1 ]] && stty size >& /dev/null
}
[[ -t 0 ]] && stty -ixon 2>/dev/null

# less
export LESS='--line-numbers --no-init --quit-if-one-screen --RAW-CONTROL-CHAR --hilite-search --jump-target=10 --chop-long-lines --shift 5 -P?f--Less-- %f: %pb%'
export LESS_TERMCAP_mb=$'\e[1;36m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESSOPEN='| src-hilite-lesspipe.sh %s'

# Misc env
export TMUX_TMPDIR='/var/tmp'
export PYTHONDONTWRITEBYTECODE=1
[[ -o interactive ]] && export GPG_TTY="$(tty)"

# Runtime tools
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
[[ -f "$HOME/.deno/env" ]] && . "$HOME/.deno/env"

export PYENV_ROOT="$HOME/.pyenv"
export GOPATH="$HOME/go:$HOME/go/ugo:$HOME/go/go_test"
if command -v go >/dev/null 2>&1; then
  export GOROOT="$(go env GOROOT 2>/dev/null)"
fi

# PATH (dedup)
typeset -U path PATH
path=(
  /sbin
  /usr/sbin
  $path
)

[[ -d /opt/local/bin ]] && path+=(/opt/local/bin)
[[ -d /opt/local/sbin ]] && path+=(/opt/local/sbin)
[[ -d "$HOME/.nodebrew/current/bin" ]] && path+=("$HOME/.nodebrew/current/bin")
[[ -d "$HOME/anaconda3/bin" ]] && path+=("$HOME/anaconda3/bin")
[[ -d "$HOME/go/bin" ]] && path+=("$HOME/go/bin")
[[ -d "$HOME/go/ugo/bin" ]] && path+=("$HOME/go/ugo/bin")
[[ -d "$HOME/go/go_test/bin" ]] && path+=("$HOME/go/go_test/bin")
[[ -d "$HOME/.local/bin" ]] && path+=("$HOME/.local/bin")
[[ -d "$PYENV_ROOT/bin" ]] && path+=("$PYENV_ROOT/bin")
[[ -d /opt/poetry/bin ]] && path+=(/opt/poetry/bin)
[[ -d "$HOME/.pulumi/bin" ]] && path+=("$HOME/.pulumi/bin")
[[ -d "$HOME/.cargo/bin" ]] && path+=("$HOME/.cargo/bin")
[[ -d "$HOME/.antigravity/antigravity/bin" ]] && path+=("$HOME/.antigravity/antigravity/bin")

export PATH
[[ -d /opt/local/man ]] && export MANPATH="/opt/local/man:${MANPATH:-}"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# fzf
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.deno/env"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"

# GO
export GOPATH=$HOME/go:$HOME/go/ugo:$HOME/go/go_test
export GOROOT=$( go env GOROOT )

# PATH
export PATH=/sbin:/usr/sbin:$PATH
export PATH=$PATH:$HOME/.nodebrew/current/bin

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export PATH=$HOME/anaconda3/bin:$PATH

export PATH=$HOME/.local/bin:$PATH

export PATH=$HOME/anaconda3/bin:$PATH

export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="/opt/poetry/bin:$PATH"

export PATH=$PATH:$HOME/.pulumi/bin

export PATH=$PATH:$HOME/.cargo/bin

export PATH=$PATH:$HOME/win32yank/win32yank-x64


# autojump
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# . "$HOME/.local/bin/env"

# Added by Antigravity
export PATH="/Users/hiroshi/.antigravity/antigravity/bin:$PATH"

# mise
eval "$(mise activate zsh)"

# 最後
clean_path() {
  awk -v RS=':' '!a[$0]++' <<<"$PATH" | paste -sd:
}
export PATH="$(clean_path)"

# Optional user files
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions
[[ -f ~/.zsh_private ]] && source ~/.zsh_private
[[ -f ~/.zsh_private_aliases ]] && source ~/.zsh_private_aliases
