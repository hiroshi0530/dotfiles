# shellcheck shell=bash

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if command -v aws_completer >/dev/null 2>&1; then
  complete -C aws_completer aws
fi

if [ -f /usr/share/git/completion/git-completion.bash ]; then
  . /usr/share/git/completion/git-completion.bash
fi

if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  . /usr/share/git/completion/git-prompt.sh
fi

if command -v gh >/dev/null 2>&1; then
  eval "$(gh completion -s bash)"
fi
