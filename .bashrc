# shellcheck shell=bash

# Common helpers for bashrc modules.
source_if_exists() {
  [ -f "$1" ] && . "$1"
}

path_prepend() {
  [ -n "$1" ] || return
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}

path_append() {
  [ -n "$1" ] || return
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="${PATH:+$PATH:}$1" ;;
  esac
}

add_prompt_command() {
  [ -n "$1" ] || return
  case ";${PROMPT_COMMAND};" in
    *";$1;"*) ;;
    *) PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }$1" ;;
  esac
}

# Core environment available to interactive and non-interactive shells.
source_if_exists "$HOME/.bashrc.d/00-env.sh"
source_if_exists "$HOME/.bashrc.d/20-path.sh"

# If not running interactively, do not apply interactive-only settings.
case $- in
  *i*) ;;
  *) return ;;
esac

source_if_exists "$HOME/.bashrc.d/10-history.sh"
source_if_exists "$HOME/.bashrc.d/30-terminal.sh"
source_if_exists "$HOME/.bashrc.d/40-less.sh"
source_if_exists "$HOME/.bashrc.d/50-completion.sh"
source_if_exists "$HOME/.bashrc.d/60-prompt.sh"
source_if_exists "$HOME/.bashrc.d/70-tools.sh"
source_if_exists "$HOME/.bash_aliases"
source_if_exists "$HOME/.bash_functions"
source_if_exists "$HOME/.bash_private_aliases"

# Motd helper output.
[ -f /etc/motd.sslcheck ] && cat /etc/motd.sslcheck
