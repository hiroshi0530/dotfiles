#!/bin/bash

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
