# shellcheck shell=bash

alias cl='clear'
alias e='exit'
alias da='direnv allow'

alias ll='ls -alGh'
alias la='ll -Ah'
alias l='ls -CFh'
alias df='df -H -m'
alias du='du -H -m'
alias h='history'
alias dmesg='dmesg -T'

alias cp='cp -i -p'
alias mv='mv -i'
alias rm='rm -i'

alias date='env LANG=C date'
alias sort='env LC_ALL=C sort'

alias grep='env -u LC_CTYPE grep --color=always'
alias zgrep='env -u LC_CTYPE zgrep --color=always'
export GREP_COLOR='01;41'

alias sdiff='sdiff -l'
alias pdiff='diff -aurN'

alias tree='tree -NF'
alias ftree='tree -afipugsDf'

alias gtags='gtags -v'
alias htags='htags -vsF'

alias wget='wget --trust-server-names --timeout=60'

alias cls='echo -ne "\ec\e[3J"'

alias ipconfig='cocot ipconfig'
alias nslookup='cocot nslookup'
alias netsh='cocot netsh'
alias net='cocot net'
alias shutdown='cocot shutdown'
alias systeminfo='cocot systeminfo'
alias tasklist='cocot tasklist'
alias taskkill='cocot taskkill'
alias xcopy='cocot xcopy'
alias attrib='cocot attrib'

alias nst='netstat -autn'
alias ctags='ctags -R --exclude=.git --exclude=log --exclude=node_modules *'
