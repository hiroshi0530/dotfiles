# shellcheck shell=bash

export EDITOR='vim'
export PAGER='less'
umask 022

export PYTHONDONTWRITEBYTECODE=1
export SHELL='/bin/bash'

# Locale settings.
export LC_ALL='en_US.UTF-8'
export LC_CTYPE='ja_JP.UTF-8'

# Required for GPG signing in terminal sessions.
if [ -t 1 ]; then
  export GPG_TTY
  GPG_TTY="$(tty)"
fi
