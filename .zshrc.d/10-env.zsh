# shellcheck shell=zsh
export EDITOR='nvim'
export PAGER='less'
umask 022

export TMUX_TMPDIR='/var/tmp'
export PYTHONDONTWRITEBYTECODE=1
# shellcheck disable=SC2155
[[ -o interactive ]] && export GPG_TTY="$(tty)"
