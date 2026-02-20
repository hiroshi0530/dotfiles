# shellcheck shell=bash

shopt -s expand_aliases

alias_source_if_exists() {
  [ -f "$1" ] && . "$1"
}

alias_root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
alias_modules_dir="${alias_root_dir}/.bash_aliases.d"

alias_source_if_exists "${alias_modules_dir}/00-navigation.sh"
alias_source_if_exists "${alias_modules_dir}/10-system.sh"
alias_source_if_exists "${alias_modules_dir}/20-git.sh"
alias_source_if_exists "${alias_modules_dir}/30-dev.sh"
alias_source_if_exists "${alias_modules_dir}/90-functions.sh"

unset -v alias_root_dir alias_modules_dir
unset -f alias_source_if_exists
