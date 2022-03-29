#!/bin/bash

main () {

  if [ -n "$SESSION_NAME" ];then
    session=$SESSION_NAME
  else
    session=multi-ssh-`date +%s`
  fi
  window=multi-ssh

  ### tmuxのセッションを作成
  tmux new-session -d -n $window -s $session
   
  ### 各ホストにsshログイン
  # 最初の1台はsshするだけ
  # tmux send-keys "ssh -i ijps-sky18-dev-key.pem ec2-user@$1" C-m
  tmux send-keys "$1" C-m C-m
  shift

  # 残りはpaneを作成してからssh
  for i in $*;do
    tmux split-window
    tmux select-layout tiled
    # tmux send-keys "ssh -i ijps-sky18-dev-key.pem ec2-user@$i" C-m
    tmux send-keys "$i" C-m C-m
  done

  ### 最初のpaneを選択状態にする
  tmux select-pane -t 0

  ### paneの同期モードを設定
  tmux set-window-option synchronize-panes on

  ### セッションにアタッチ
  tmux attach-session -t $session

}

main ssh_k1 ssh_k2 ssh_k3 ssh_k4

