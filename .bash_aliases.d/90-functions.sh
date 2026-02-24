# shellcheck shell=bash

if [[ $- =~ i ]] && [ -f "$HOME/.inputrc" ]; then
  bind -f "$HOME/.inputrc"
fi

gchange_author_committer() {
  git filter-branch -f --env-filter "GIT_AUTHOR_NAME='$1'; GIT_AUTHOR_EMAIL='$2'; GIT_COMMITTER_NAME='$1'; GIT_COMMITTER_EMAIL='$2';" HEAD
}

gchange_author_committer_w0530() {
  git filter-branch -f --env-filter "GIT_AUTHOR_NAME='whiroshi0530'; GIT_AUTHOR_EMAIL='whiroshi0530@gmail.com'; GIT_COMMITTER_NAME='whiroshi0530'; GIT_COMMITTER_EMAIL='whiroshi0530@gmail.com';" HEAD
}

psa() {
  ps aux | grep "$1"
}

dcexec() {
  docker-compose exec "$1" /bin/bash
}

mkcd() {
  mkdir "$1" && cd "$1"
}

cc() {
  perl -pe 's#(_|^)(.)#\u$2#g'
}

hd() {
  d="$(date -u '+%Y-%m-%d')"
  echo "date: $d"
}

sc() {
  perl -pe 's#([A-Z])#_\L$1#g' | perl -pe 's#^_##'
}

hdate() {
  d="$(date '+%Y-%m-%dT%H:%M:%S+09:00')"
  echo "date: $d"
}

hlastdate() {
  d="$(date '+%Y-%m-%dT%H:%M:%S+09:00')"
  echo "lastmod: $d"
}

number24() {
  seq -w 24
}

ca() {
  conda activate "$1"
}

cda() {
  conda deactivate
}

md_to_latex() {
  pandoc -r markdown-auto_identifiers -w latex "$1.md" -o "$1.tex"
}
