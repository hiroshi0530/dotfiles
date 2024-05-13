# 190115 aliasをvim :!コマンドから実行できるようにする
shopt -s expand_aliases

# builtin
alias c='cd ..'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'
alias ......='cd ../../../../../../'

# program
alias p='python'
alias r='ruby'

# vim
alias v='vim'
alias vd='vimdiff'
alias vr='vim -R'
alias svi='set -o vi'

# some more ls aliases
alias cl='clear'
alias e='exit'
alias da='direnv allow'

alias ll='ls -alGh'
# alias ll='ls -altrGh'
alias la='ll -Ah'
alias l='ls -CFh'
alias df='df -Th'
alias h='history'
alias dmesg='dmesg -T'

alias cp='cp -i -p'
alias mv='mv -i'
alias rm='rm -i'

alias date='env LANG=C date'
alias sort='env LC_ALL=C sort'
alias df='df -H -m'
alias du='du -H -m'

# grep
alias grep='env -u LC_CTYPE grep --color=always'
alias zgrep='env -u LC_CTYPE zgrep --color=always'
export GREP_COLOR='01;41'

# diffutils
alias sdiff='sdiff -l'
alias pdiff='diff -aurN'

# tree
alias tree='tree -NF'
alias ftree='tree -afipugsDf'

# global
alias gtags='gtags -v'
alias htags='htags -vsF'

# wget
alias wget='wget --trust-server-names --timeout=60'

# mintty
alias cls='echo -ne "\ec\e[3J"'

# windows native appliation
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


# aliases for git
alias gall='ga && gcu && gpom'
alias grh='git reset --hard'
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
    # bind -f $DIR/.inputrc
    bind -f ~/.inputrc
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

alias gcm='git checkout master'
alias gcd='git checkout develop'

alias gl='git log --graph --date=short --decorate=short --pretty=format:'\''%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'\'''
alias gb='git branch -a'
alias gr='git remote -v'
alias gf='git fetch --all'

alias gconf='git config --list'

alias gas='git am --show-current-patch'

function gchange_author_committer () {
  git filter-branch -f --env-filter "GIT_AUTHOR_NAME='$1'; GIT_AUTHOR_EMAIL='$2'; GIT_COMMITTER_NAME='$1'; GIT_COMMITTER_EMAIL='$2';" HEAD
}

function gchange_author_committer_w0530 () {
  git filter-branch -f --env-filter "GIT_AUTHOR_NAME='whiroshi0530'; GIT_AUTHOR_EMAIL='whiroshi0530@gmail.com'; GIT_COMMITTER_NAME='whiroshi0530'; GIT_COMMITTER_EMAIL='whiroshi0530@gmail.com';" HEAD
}


# vim
alias vb='vim ~/.bashrc'
alias vv='vim ~/.vimrc'
alias va='vim ~/.bash_aliases'
alias vf='vim ~/.bash_functions'
alias vpa='vim ~/.bash_private_aliases'
alias vt='vim ~/.tmux.conf'

alias loadb='source ~/.bashrc'

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


alias drc='docker ps -aq | xargs docker rm' # 全コンテナの削除
alias dri='docker ps -aq | xargs docker rmi -f' # 全イメージの削除

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

# rails
alias rs='rails server'
alias rr='rails routes'
alias rdm='rails db:migrate'
alias rgc='rails generate controller'
alias rdc='rails destroy controller'
alias rgm='rails generate model'
alias rdm='rails destroy model'
alias rr='rails routes'
alias rc='rails console'

# hugo
# alias hs='hugo server'
alias hsd='hugo server --buildDrafts --buildFuture --cleanDestinationDir --enableGitInfo  --forceSyncStatic --ignoreCache --watch'
alias hs='hugo server --buildFuture --cleanDestinationDir --enableGitInfo  --forceSyncStatic --ignoreCache --watch'

# bundler
alias bip='bundle install --path vendor/bundler' 

# jupyter
alias jn='jupyter notebook'

function dcexec () { 
  docker-compose exec $1 /bin/bash;
} 

# network
alias nst='netstat -autn'

# ctags
alias ctags='ctags -R --exclude=.git --exclude=log --exclude=node_modules *'

# file system 
function mkcd() { 
  mkdir $1 && cd $1
} 

# convert to snakecase to camelcase
function cc() {
  perl -pe 's#(_|^)(.)#\u$2#g'
}

# convert to camelcase to snakecase
function hd() {
  d=$(date -u "+%Y-%m-%d")
  echo "date: "\"$d\"
}

function sc() {
  perl -pe 's#([A-Z])#_\L$1#g' | perl -pe 's#^_##'
}

function hdate() {
  d=$(date "+%Y-%m-%dT%H:%M:%S+09:00")
  echo "date: "$d
}

function hlastdate() {
  d=$(date "+%Y-%m-%dT%H:%M:%S+09:00")
  echo "lastmod: "$d
}

function number24() {
  seq -w 24
}

function ca() {
  conda activate $1
}

function cda() {
  conda deactivate
}

alias ruby='~/.rbenv/versions/3.0.1/bin/ruby'

function md_to_latex() {
  pandoc -r markdown-auto_identifiers -w latex $1.md -o $1.tex
}

# poetry
alias pr='poetry run'
alias pi='poetry install'
alias prp='poetry run python'
