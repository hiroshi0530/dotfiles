#!/bin/bash

echo "start instal"

SCRIPT_DIR=$(cd $(dirname $0); pwd)

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue

  echo $HOME/$f

[[ -f $HOME/$f ]] && echo "delete syblic link" && rm -f $HOME/$f
[[ -d $HOME/$f ]] && echo "delete syblic link" && rm -f $HOME/$f
[[ -L $HOME/$f ]] && echo "delete syblic link" && rm -f $HOME/$f
  # rm -f $HOME/$f

  ln -s $SCRIPT_DIR/$f $HOME/$f

done

# copy .gitconfig.local .gitconfig
cp .gitconfig.local "$HOME/.gitconfig"

# set ipython vim mode
[[ ! -d ~/.ipython/profile_default/ ]] && mkdir -p ~/.ipython/profile_default && echo 'c.TerminalInteractiveShell.editing_mode = \"vi\"' > ~/.ipython/profile_default/ipython_config.py

# mkdir for swap file
mkdir -p ~/swap

# 201125: git diff-highlightのリンクの追加
DIFF_HIGHLIGHT_SRC=/usr/local/share/git-core/contrib/diff-highlight/diff-highlight
DIFF_HIGHLIGHT_DST=/usr/local/bin/diff-highlight
if [[ -x "$DIFF_HIGHLIGHT_SRC" && ( ! -e "$DIFF_HIGHLIGHT_DST" ) ]]; then
  ln -s "$DIFF_HIGHLIGHT_SRC" "$DIFF_HIGHLIGHT_DST"
else
  echo "skip diff-highlight link (missing or already exists)"
fi
