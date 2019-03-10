# 190115 aliasをvim :!コマンドから実行できるようにする
shopt -s expand_aliases

# ichihara-san setting
# some more ls aliases
alias c='clear'
alias e='exit'
alias da='direnv allow'

alias ll='ls -ltrh'
alias la='ll -A'
alias l='ls -CF'
alias df='df -Th'
alias h='history'
alias dmesg='dmesg -T'

# aliases for git
alias gall='ga && gcu && gpom'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard && git clean -dfx'
alias gm="git merge"
alias g='git'
alias get='git'
alias gs='git status'
alias gss='git status -s'
alias gl='git pull'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin'

alias gdv='git diff -w "$@" | vim -R -'

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git checkout master'
alias gci='git commit --interactive'
alias gb='git --no-pager branch'
alias gba='git --no-pager branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
#alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gg="git log --graph --pretty=format:'%h -%d %s (%cr)' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias gw="git whatchanged"
alias gt="git tag"
alias gta="git tag -a"
alias gtd="git tag -d"
alias gtl="git tag -l"

alias grv='git remote -v'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gbr='git branch --remote'
alias gcl='git config --list'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=10'
alias glgg='git log --graph --max-count=10'
alias glgga='git log --graph --decorate --all'
alias glo='git log --oneline --decorate --color'
alias glog='git log --oneline --decorate --color --graph'
alias gsts='git stash show --text'
alias gstl='git --no-pager stash list'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'

# also load inputrc
if [[ $- =~ i ]]; then
    DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
    bind -f $DIR/.inputrc
fi

# orinal setting
alias vi='vim'
alias view='vim -R'

alias gs='git status'
alias gda='git diff'
alias gdc='git diff ^HEAD'
alias ga='git add .'

alias gplom='git pull origin master'
alias gphom='git push origin master'

alias gplod='git pull origin develop'
alias gphod='git push origin develop'

alias gl='git log --graph --date=short --decorate=short --pretty=format:'\''%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'\'''
alias gb='git branch -a'
alias gr='git remote -v'
alias gf='git fetch --all'

alias gconf='git config --list'

alias gas='git am --show-current-patch'

function gc () { 
  git commit -m '$1'; 
} 

function gpod () { 
  git push origin develop/v$1; 
} 

# vim
alias vimb='vim ~/.bashrc'
alias vimv='vim ~/.vimrc'
alias vima='vim ~/.bash_aliases'
alias vimf='vim ~/.bash_functions'
alias vimpa='vim ~/.bash_private_aliases'
alias vimt='vim ~/.tmux.conf'

alias loadb='source ~/.bashrc'

alias .="cd ../"
alias ..="cd ../../"

function psa () { 
  ps aux | grep $1;
} 

# tmux
alias tls='tmux ls'
alias tlsc='tmux lsc'
alias tkill='tmux kill-server'
alias tkills='tmux kill-session'
alias tkillw='tmux kill-window'

# docker
alias di='docker images'
alias dps='docker ps -a'
alias dcl='docker container ls -a'

function dstart () { 
  docker container start $1;
} 

function dstop () { 
  docker container stop $1;
} 

function dcrm () { 
  docker container rm $1;
} 

function dirm () { 
  docker image rm $1;
} 

function dcrm () { 
  docker container rm $1;
} 

# docker-compose
alias dcbd='docker-compose build --no-cache'
alias dcup='docker-compose up -d --build'
alias dcps='docker-compose ps'
alias dcpq='docker-compose ps -q'
alias dcim='docker-compose images'
alias dcsp='docker-compose stop'
alias dcst='docker-compose start'
alias dcrs='docker-compose restart'
alias dcrm='docker-compose rm'

alias dcdw='docker-compose down' # 停止＆削除（コンテナ・ネットワーク）
alias dcdwv='docker-compose down -v' # 停止＆削除（コンテナ・ネットワーク・イメージ）
alias dcdwall='docker-compose down --rmi all' # 停止＆削除（コンテナ・ネットワーク・ボリューム）

function dcexec () { 
  docker-compose exec $1 /bin/bash;
} 

# network
alias nst='netstat -autn'

# file system 
function mkcd() { 
  mkdir $1 && cd $1
} 

# convert to snakecase to camelcase
function cc() {
  perl -pe 's#(_|^)(.)#\u$2#g'
}

# convert to camelcase to snakecase
function sc() {
  perl -pe 's#([A-Z])#_\L$1#g' | perl -pe 's#^_##'
}

