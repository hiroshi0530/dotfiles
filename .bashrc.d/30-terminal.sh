# shellcheck shell=bash

shopt -s no_empty_cmd_completion
set -o vi
bind 'set horizontal-scroll-mode off'
shopt -s checkwinsize

complete -d cd
complete -c man command type which
complete -A setopt set
complete -A shopt shopt
complete -a unalias
complete -b builtin
complete -A binding bind

# Terminal line editing tweaks.
if [ -t 1 ]; then
  stty -ixon
  stty -ixoff
  stty werase undef
fi

bind '"\C-w": unix-filename-rubout'

export TERM_TITLE="bash @${HOSTNAME}"
export TMUX_TMPDIR='/var/tmp'
