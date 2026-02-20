# shellcheck shell=bash

export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL='ignoredups'
export HISTIGNORE='?:??:???:exit'

shopt -s cmdhist
shopt -s histverify
shopt -s histreedit
shopt -s histappend

# Share history across terminals.
add_prompt_command 'history -a'
add_prompt_command 'history -c'
add_prompt_command 'history -r'
