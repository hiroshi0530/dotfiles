# shellcheck shell=zsh
# Custom PS1: ~/AAA/BBB/CCC $
#
# - ホームディレクトリは ~ に短縮
# - 中間ディレクトリは先頭3文字に省略、末尾のみフルネーム

function _prompt_short_pwd {
  local full_path="$PWD"
  local shortened_path=""
  local part
  local last_part

  if [[ $full_path == "$HOME" || $full_path == "$HOME"/* ]]; then
    shortened_path="~"
    full_path=${full_path#"$HOME"}
  fi

  # shellcheck disable=SC2296,SC2206
  local path_parts=(${(s:/:)full_path})

  if [[ ${#path_parts[@]} -le 0 ]]; then
    [[ -n "$full_path" ]] && shortened_path+="$full_path"
    echo "$shortened_path"
    return
  fi

  last_part=${path_parts[-1]}

  for part in ${path_parts[1,-2]}; do
    if [[ -n "$part" ]]; then
      shortened_path+="/${part:0:3}"
    fi
  done

  shortened_path+="/$last_part"
  echo "$shortened_path"
}

setopt PROMPT_SUBST
export PS1='$(_prompt_short_pwd) $ '
