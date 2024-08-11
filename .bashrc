## ####################################################################

## @ 環境設定

   # エディタ
     export EDITOR='vim'

   # ページャー
     export PAGER='less'

   # 新規ファイルの権限を設定
     umask 022

   # スクリプト中の CRを無視
   #  set -o igncr

## ####################################################################
## @ コマンド補完

   # 無入力時の補完を無視
     shopt -s no_empty_cmd_completion

   # ディレクトリの補完
     complete -d cd

   # コマンドの補完
     complete -c man command type which

   # シェルオプションの補完
     complete -A setopt set
     complete -A shopt shopt

   # エイリアスの補完
     complete -a unalias

   # ビルドインコマンドの補完
     complete -b builtin

   # キーバインドの補完
     complete -A binding bind

   # bash completionの読み込み
   # if [ -f /etc/bash_completion ]; then
   #     . /etc/bash_completion
   # fi


## ####################################################################
## @ コマンド履歴

   # 履歴ファイルの最大履歴数
     export HISTFILESIZE
     HISTFILESIZE='10240'

   # 実行中プロセスの最大履歴数
     export HISTSIZE
     HISTSIZE='10240'

   # 連続した重複履歴を排除
     export HISTCONTROL
     HISTCONTROL='ignoredups'

   # 1～3文字のコマンドと exitを履歴記録対象から除外
     export HISTIGNORE
     HISTIGNORE='?:??:???:exit'

   # 複数行コマンドのコマンド履歴を追加
     shopt -s cmdhist

   # 編集バッファにコマンド履歴を読み込み
     shopt -s histverify
     shopt -s histreedit

   # コマンド履歴の追記モードを無効化
   # shopt -u histappend

   # 複数端末間でコマンド履歴を共有
     export PROMPT_COMMAND
     PROMPT_COMMAND="history -a; history -c; history -r"


## ####################################################################
## @ ターミナル

   # 画面サイズ（LINES/COLUMNS）を自動更新
     shopt -s checkwinsize
     export LINES COLUMNS

   # XON/XOFF によるフローコントロールを有効化
     stty -ixon

   # 入力バッファ状態に応じた start/stopキャラクタの送信機能を有効化
     stty -ixoff

   # C-Vによるクリップボード貼り付けのため、quoted-insertを無効化
   # stty lnext ^q stop undef start undef

   # コマンドプロンプト
  #    export PS1 PS2
  #    case $TERM in
  #        xterm*|emacs)
  #            PS1="\$(
  #                echo -ne \"\e]0;\$TERM_TITLE\a\"
  #                bar=\" \[\e[0;31;41m\]#\[\e[0m\e[0;37m\] \"
  #                echo -ne \"\n\"
  #                echo -ne \"\${bar}Host: \H | User: \u | Time: \D{%Y-%m-%d %H:%M:%S}\n\"
  #                echo -ne \"\${bar}Path: \w\n\"
  #                echo -ne \"\${bar}# \[\e[0m\]\"
  #            )"
  #            PS2="   > "
  #            function check_return_code {
  #                retv=$?
  #                if [[ ! $check_return_code ]] ; then
  #                    check_return_code=1
  #                    return
  #                fi
  #                if [[ $retv -eq 0 ]] ; then
  #                    echo -ne "\n\e[0;32m ✔ \e[0;37mSuccess (retv = $retv)\n\e[2;32m "
  #                else
  #                    echo -ne "\n\e[0;33m ✗ \e[0;37mFailure (retv = $retv)\n\e[2;33m "
  #                fi
  #            }
  #            export PROMPT_COMMAND
  #            PROMPT_COMMAND="check_return_code; $PROMPT_COMMAND"
  #            ;;
  #        dumb|*)
  #            PS1="\n[Host: \H | User: \u | Time: \D{%Y-%m-%d %H:%M:%S} | Retv: \$? ]\n[Path: \w]\n# "
  #            PS2="> "
  #            ;;
  #    esac

   # タイトル
     export TERM_TITLE
     TERM_TITLE="bash @$HOSTNAME"


## ####################################################################
## @ less

   # オプション
     export LESS
     LESS=
     LESS="$LESS --line-numbers"                # 行番号を非表示
     LESS="$LESS --no-init"                     # termcap初期化文字列の送信を抑止
     LESS="$LESS --quit-if-one-screen"          # 単一ページ表示時に lessを自動終了
     LESS="$LESS --RAW-CONTROL-CHAR"            # 制御文字を処理して表示
     LESS="$LESS --hilite-search"               # 検索マッチ文字列をハイライト
     LESS="$LESS --jump-target=10"              # ターゲット行を10行目に指定
     LESS="$LESS --chop-long-lines --shift 5"   # 折り返し表示無効
     LESS="$LESS -P?f--Less-- %f\: %pb\%"

   # 配色（太字）
     export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me
     LESS_TERMCAP_mb=$'\e[1;36m'    # begin blinking
     LESS_TERMCAP_md=$'\e[1;36m'    # begin bold
     LESS_TERMCAP_me=$'\e[0m'       # end mode

   # 配色（モードライン）
     export LESS_TERMCAP_se LESS_TERMCAP_so
     LESS_TERMCAP_so=$'\e[1;44m'    # begin standout-mode - info box
     LESS_TERMCAP_se=$'\e[0m'       # end standout-mode
 
   # 配色（アンダーライン）
     export LESS_TERMCAP_ue LESS_TERMCAP_us
     LESS_TERMCAP_us=$'\e[4;33m'    # begin underline
     LESS_TERMCAP_ue=$'\e[0m'       # end underline

   # ソースコードのハイライト
     export LESSOPEN
     LESSOPEN="| src-hilite-lesspipe.sh %s"


## ####################################################################
## @ tmux

   # tmpディレクトリ
     export TMUX_TMPDIR
     TMUX_TMPDIR="/var/tmp"


## ####################################################################
## @ ユーザ関数

   # クリップボード上のパスにディレクトリ移動
     function ccd {
         local dir="$(cat /dev/clipboard)"
         if [[ -d "$dir" ]] ; then
             builtin cd "$dir"
         else
             builtin cd /desktop
         fi
     }

   # ANISカラーコード表示
     function ansi_color {
         for a in 3 4 ; do
             for b in 0 1 2 4 7 ; do
                 for n in ${a}0 ${a}1 ${a}2 ${a}3 ${a}4 ${a}5 ${a}6 ${a}7 ; do
                     echo -en "\e[${b};${n}m"
                     echo -n  "\e[${b};${n}m"
                     echo -ne "\e[0m"
                     echo -n  "  "
                 done
                 echo
             done
             echo
         done
     }

   # コマンド未検出時の制御
     function command_not_found_handle {
         echo "$SHELL: $1: command not found"
         return 127
     }


## ####################################################################
## @ 配色設定

     case $TERM in
         xterm*)
           # . $HOME/.minttyrc.solarized.light
           # . $HOME/.minttyrc.solarized.dark
           #  . $HOME/.minttyrc.gnupack.dark
         ;;
     esac


## ####################################################################

set -o vi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    source ~/.bash_functions
fi

if [ -f ~/.bash_private_aliases ]; then
    source ~/.bash_private_aliases
fi

# Append to the history file, don't overwrite it.
shopt -s histappend

#export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# History size up
export HISTSIZE=100000
export HISTFILESIZE=100000

export PATH=/sbin:/usr/sbin:$PATH


export LESS="iSMR"
set -o vi
bind 'set horizontal-scroll-mode off'

stty werase undef
bind '"\C-w": unix-filename-rubout'

if [ -f /etc/motd.sslcheck ]; then
    cat /etc/motd.sslcheck
fi

complete -C aws_completer aws


 ####################################################################
 ####################################################################
 ####################################################################
 ####################################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


## 180305 install pip install trach-pu
if type trash-put &> /dev/null
then
	alias rm=trash-put
fi

function share_history {
	history -a
	history -c
	history -r
}
PROMPT_COMMANDG='share_history'
export PATH=$PATH:$HOME/.nodebrew/current/bin

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash && cd - > /dev/null
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash && cd - > /dev/null

eval "$(direnv hook bash)"

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export PATH=$HOME/anaconda3/bin:$PATH

# for golang
export GOPATH=$HOME/go:$HOME/go/ugo:$HOME/go/go_test
export GOROOT=$( go env GOROOT )
export PATH=$GOPATH/bin:$PATH

# for awscli
export PATH=$HOME/.local/bin:$PATH

# for anaconda
export PATH=$HOME/anaconda3/bin:$PATH

# 190107
# 重複するPATHの削除
# 連想配列が使えるかどうかチェック
if typeset -A &>/dev/null; then
  # 使える場合
  typeset -A _paths
  typeset _results
  while read -r _p; do
    if [[ -n ${_p} ]] && (( ${_paths["${_p}"]:-1} )); then
      _paths["${_p}"]=0
      _results=${_results}:${_p}
    fi
  done <<<"${PATH//:/$'\n'}"
  PATH=${_results/:/}
  unset -v _p _paths _results
else
  # 使えない場合はawk
  typeset _p=$(awk 'BEGIN{RS=":";ORS=":"} !x[$0]++' <<<"${PATH}:")
  PATH=${_p%:*:}
  unset -v _p
fi

export PS1="\w $ "

# git 補完
# source /usr/local/etc/bash_completion.d/git-prompt.sh
# source /usr/local/etc/bash_completion.d/git-completion.bash
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

# pythonを実行したとき、__pycache__を生成しないようにする
export PYTHONDONTWRITEBYTECODE=1

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash

# 200805_conda
source ~/anaconda3/etc/profile.d/conda.sh

# 200805_julia
alias julia='/usr/local/bin/julia'
# exec $SHELL

eval "$(/usr/local/bin/brew shellenv)"

export SHELL="/bin/bash"

export PATH=/usr/local/texlive/2022/bin/universal-darwin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"

export PATH="/opt/poetry/bin:$PATH"

export PATH="$PATH:/opt/homebrew/share/git-core/contrib/diff-highlight"

eval "$(gh completion -s bash)"
