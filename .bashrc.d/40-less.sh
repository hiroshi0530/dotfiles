# shellcheck shell=bash

export LESS
LESS=''
LESS="$LESS --line-numbers"
LESS="$LESS --no-init"
LESS="$LESS --quit-if-one-screen"
LESS="$LESS --RAW-CONTROL-CHAR"
LESS="$LESS --hilite-search"
LESS="$LESS --jump-target=10"
LESS="$LESS --chop-long-lines --shift 5"
LESS="$LESS -P?f--Less-- %f\\: %pb\\%"

export LESS_TERMCAP_mb=$'\e[1;36m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;33m'
export LESS_TERMCAP_ue=$'\e[0m'

export LESSOPEN='| src-hilite-lesspipe.sh %s'
