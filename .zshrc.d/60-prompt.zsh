function short_pwd {
  local full_path="$PWD"
  local shortened_path=""
  local part
  local last_part

  if [[ $full_path == $HOME || $full_path == $HOME/* ]]; then
    shortened_path="~"
    full_path=${full_path#$HOME}
  fi

  local path_parts=(${(s:/:)full_path})

  if [[ ${#path_parts[@]} -le 0 ]]; then
    [[ -n "$full_path" ]] && shortened_path+="$full_path"
    echo "$shortened_path"
    return
  fi

  last_part=${path_parts[-1]}

  for part in ${path_parts[@]:0:-1}; do
    if [[ -n "$part" ]]; then
      if [[ -z "$shortened_path" ]]; then
        shortened_path+="/$part"
      else
        shortened_path+="/${part:0:3}"
      fi
    fi
  done

  shortened_path+="/$last_part"
  echo "$shortened_path"
}
export PS1='$(short_pwd) $ '
