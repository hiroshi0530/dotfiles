# ichihara-san setting
# some more ls aliases
alias ll='ls -ltrh'
alias la='ll -A'
alias l='ls -CF'
alias df='df -Th'
alias h='history'
alias dmesg='dmesg -T'

# aliases for git
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard && git clean -dfx'
alias gm="git merge"
alias g='git'
alias get='git'
alias gst='git status'
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
alias gb='git branch'
alias gba='git branch -a'
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

alias gcu='git commit -m update'
alias gcm='git commit -m modify'

alias gpom='git push origin master'
alias gl='git log --graph --date=short --decorate=short --pretty=format:'\''%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'\'''
alias gb='git branch -a'
alias gr='git remote -v'
alias gf='git fetch --all'

alias gconf='git config --list'

function gc () { 
  git commit -m '$1'; 
} 

function gpod () { 
  git push origin develop/v$1; 
} 

alias vimb='vim ~/.bashrc'
alias loadb='source ~/.bashrc'

alias .="cd ../"
alias ..="cd ../../"

function psa () { 
  ps aux | grep $1;
} 
