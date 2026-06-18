# shellcheck shell=zsh
# Starship prompt
# https://starship.rs/
#
# Fallback: minimal PS1 if starship is not installed

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  # fallback: short_pwd prompt
  function short_pwd {
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
  export PS1='$(short_pwd) $ '
fi
