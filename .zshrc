setopt glob
setopt extended_glob

# setopt prompt_subst
# # export PS1='%F{green}z) %f%~ $ '
# export PS1='%~ $ '

setopt prompt_subst
function short_pwd {
    local full_path=$PWD
    local shortened_path=""
    local part
    local last_part

    if [[ $full_path == $HOME* ]]; then
        shortened_path="~"
        full_path=${full_path#$HOME}
    fi

    local path_parts=(${(s:/:)full_path})

    if [[ ${#path_parts[@]} -le 0 ]]; then
        if [[ -n "$full_path" ]]; then
            shortened_path+="$full_path"
        fi
        echo "$shortened_path"
        return
    fi

    # 最後のディレクトリ名を取得
    last_part=${path_parts[-1]}

    # 途中のディレクトリを3文字に短縮（最初のディレクトリ名はフルで表示）
    for part in ${path_parts[@]:0:-1}; do
        if [[ -n "$part" ]]; then
            if [[ -z "$shortened_path" ]]; then
                shortened_path+="/$part"
            else
                shortened_path+="/${part:0:3}"
            fi
        fi
    done

    # 最後のディレクトリはそのままフルネームで表示
    shortened_path+="/$last_part"

    echo "$shortened_path"
}
export PS1='$(short_pwd) $ '


autoload -Uz compinit
compinit

# エディタ
export EDITOR='vim'

# ページャー
export PAGER='less'

# 新規ファイルの権限を設定
umask 022

# ディレクトリの補完
compdef _directories cd

# bashのcompleteコマンドに相当するcompdefを使用
# コマンドの補完
compdef _command man command type which

# シェルオプションの補完
compdef _setopt setopt
compdef _shopt shopt

# エイリアスの補完
compdef _aliases unalias

# ビルドインコマンドの補完
compdef _builtin builtin

# キーバインドの補完
compdef _bindkey bind

# 履歴ファイルの最大履歴数
export HISTFILESIZE=100000

# 実行中プロセスの最大履歴数
export HISTSIZE=100000

# 連続した重複履歴を排除
HISTCONTROL=ignoredups

# 1～3文字のコマンドと exitを履歴記録対象から除外
HISTIGNORE='?:??:???:exit'

export HISTFILE=$HOME/.zsh_history
export SAVEHIST=100000

# 複数行コマンドのコマンド履歴を追加
setopt inc_append_history

# 編集バッファにコマンド履歴を読み込み
setopt hist_verify

# 複数端末間でコマンド履歴を共有
setopt share_history

# ウィンドウサイズの自動更新
TRAPWINCH() {
  [[ -t 1 ]] && stty size >& /dev/null
}

# グロブが失敗してもエラーを出さない
setopt no_nomatch


# XON/XOFF によるフローコントロールを有効化
stty -ixon


# オプション
export LESS='--line-numbers --no-init --quit-if-one-screen --RAW-CONTROL-CHAR --hilite-search --jump-target=10 --chop-long-lines --shift 5 -P?f--Less-- %f: %pb%'

# 配色（太字）
export LESS_TERMCAP_mb=$'\e[1;36m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'

# 配色（モードライン）
export LESS_TERMCAP_so=$'\e[1;44m'
export LESS_TERMCAP_se=$'\e[0m'

# 配色（アンダーライン）
export LESS_TERMCAP_us=$'\e[4;33m'
export LESS_TERMCAP_ue=$'\e[0m'

# ソースコードのハイライト
export LESSOPEN="| src-hilite-lesspipe.sh %s"

####################################################################
# tmux
# tmpディレクトリ
export TMUX_TMPDIR="/var/tmp"

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
function command_not_found_handler {
    echo "$SHELL: $1: command not found"
    return 127
}

####################################################################
case $TERM in
    xterm*)
        # ソースファイルを読み込む設定
        ;;
esac

setopt vi

# Pythonの__pycache__を生成しない
export PYTHONDONTWRITEBYTECODE=1

# AWS CLIの補完
compdef _aws_completer aws

# 
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

if [ -f ~/.zsh_functions ]; then
    source ~/.zsh_functions
fi

if [ -f ~/.zsh_private ]; then
    source ~/.zsh_private
fi

if [ -f ~/.zsh_private_aliases ]; then
    source ~/.zsh_private_aliases
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U compinit && compinit -u

# GPG
export GPG_TTY=$(tty)

# OSの種類を取得
os_name=$(uname -s)

# macOSの場合
if [[ "$os_name" == "Darwin" ]]; then
    source /opt/homebrew/Cellar/fzf/0.55.0/shell/key-bindings.zsh

# Linuxの場合
elif [[ "$os_name" == "Linux" ]]; then
    
# Windows (WSL) の場合
elif [[ "$os_name" == "CYGWIN" || "$os_type" == "MINGW" || "$os_type" == "MSYS" ]]; then
    
# その他のOSの場合
else
    echo "Unknown OS detected: $os_name"
fi

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export PATH=$PATH:$HOME/go/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.deno/env"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"

# GO
export GOPATH=$HOME/go:$HOME/go/ugo:$HOME/go/go_test
export GOROOT=$( go env GOROOT )

# PATH
export PATH=/sbin:/usr/sbin:$PATH
export PATH=$PATH:$HOME/.nodebrew/current/bin

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export PATH=$HOME/anaconda3/bin:$PATH

export PATH=$HOME/go/bin:$HOME/go/ugo/bin:$HOME/go/go_test/bin:$PATH

export PATH=$HOME/.local/bin:$PATH

export PATH=$HOME/anaconda3/bin:$PATH

export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="/opt/poetry/bin:$PATH"

export PATH=$PATH:$HOME/.pulumi/bin

export PATH=$PATH:$HOME/.cargo/bin

. "$HOME/.local/bin/env"
