export EDITOR='nvim'
export PAGER='less'
umask 022

export TMUX_TMPDIR='/var/tmp'
export PYTHONDONTWRITEBYTECODE=1
[[ -o interactive ]] && export GPG_TTY="$(tty)"
