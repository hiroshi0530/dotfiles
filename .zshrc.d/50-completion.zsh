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
