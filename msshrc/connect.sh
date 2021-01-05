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
  tmux send-keys "ssh $1" C-m
  shift

  # 残りはpaneを作成してからssh
  for i in $*;do
    tmux split-window
    tmux select-layout tiled
    # tmux send-keys "ssh -i ijps-sky18-dev-key.pem ec2-user@$i" C-m
    tmux send-keys "ssh $i" C-m
  done

  ### 最初のpaneを選択状態にする
  tmux select-pane -t 0

  ### paneの同期モードを設定
  tmux set-window-option synchronize-panes on

  ### セッションにアタッチ
  tmux attach-session -t $session

}

main ijps-sky18-dv1-ec2-sky ijps-sky18-dv2-ec2-sky ijps-sky18-ev1-ec2-sky ijps-sky18-ev2-ec2-sky

# alias sdv1="ssh ijps-sky18-dv1-ec2-sky"
# alias sdv1acs1="ssh ijps-sky18-dv1-ec2-sslacs1"
# alias sdv1acs2="ssh ijps-sky18-dv1-ec2-sslacs2"
# alias sdv1ssl="ssh ijps-sky18-dv1-ec2-sslsky"
# alias sdv1xmpp="ssh ijps-sky18-dv1-ec2-xmpp"
# 
# alias sdv2="ssh ijps-sky18-dv2-ec2-sky"
# alias sdv2acs1="ssh ijps-sky18-dv2-ec2-sslacs1"
# alias sdv2acs2="ssh ijps-sky18-dv2-ec2-sslacs2"
# alias sdv2ssl="ssh ijps-sky18-dv2-ec2-sslsky"
# alias sdv2xmpp="ssh ijps-sky18-dv2-ec2-xmpp"
# 
# alias sev1="ssh ijps-sky18-ev1-ec2-sky"
# alias sev1acs1="ssh ijps-sky18-ev1-ec2-sslacs1"
# alias sev1acs2="ssh ijps-sky18-ev1-ec2-sslacs2"
# alias sev1ssl="ssh ijps-sky18-ev1-ec2-sslsky"
# alias sev1xmpp="ssh ijps-sky18-ev1-ec2-xmpp"
# 
# alias sev2="ssh ijps-sky18-ev2-ec2-sky"
# alias sev2acs1="ssh ijps-sky18-ev2-ec2-sslacs1"
# alias sev2acs2="ssh ijps-sky18-ev2-ec2-sslacs2"
# alias sev2ssl="ssh ijps-sky18-ev2-ec2-sslsky"
# alias sev2xmpp="ssh ijps-sky18-ev2-ec2-xmpp"
# 
# alias sstg="ssh ijps-sky18-stg-ec2-sky"
# alias sstgacs1="ssh ijps-sky18-stg-ec2-sslacs1"
# alias sstgacs2="ssh ijps-sky18-stg-ec2-sslacs2"
# alias sstgssl="ssh ijps-sky18-stg-ec2-sslsky"
# alias sstgxmpp="ssh ijps-sky18-stg-ec2-xmpp"
# 
# alias sprdijw="ssh ijps-sky18-product-ec2-ijw-jva-01"
# alias sprdmanager="ssh ijps-sky18-product-ec2-manager"
# 
# alias sprdjva01="ssh ijps-sky18-product-ec2-sky-jva-01"
# alias sprdjva02="ssh ijps-sky18-product-ec2-sky-jva-02"
# alias sprdjva03="ssh ijps-sky18-product-ec2-sky-jva-03"
# alias sprdjva04="ssh ijps-sky18-product-ec2-sky-jva-04"
# alias sprdjva05="ssh ijps-sky18-product-ec2-sky-jva-05"
# alias sprdjva06="ssh ijps-sky18-product-ec2-sky-jva-06"
# alias sprdjva07="ssh ijps-sky18-product-ec2-sky-jva-07"
# alias sprdjva08="ssh ijps-sky18-product-ec2-sky-jva-08"
# 
# alias sprdweb01="ssh ijps-sky18-product-ec2-sky-web-01"
# alias sprdweb02="ssh ijps-sky18-product-ec2-sky-web-02"
# alias sprdweb03="ssh ijps-sky18-product-ec2-sky-web-03"
# alias sprdweb04="ssh ijps-sky18-product-ec2-sky-web-04"
# alias sprdweb05="ssh ijps-sky18-product-ec2-sky-web-05"
# alias sprdweb06="ssh ijps-sky18-product-ec2-sky-web-06"
# alias sprdweb07="ssh ijps-sky18-product-ec2-sky-web-07"
# alias sprdweb08="ssh ijps-sky18-product-ec2-sky-web-08"
# 
# alias sprdacs1="ssh ijps-sky18-product-ec2-ssl-acs1"
# alias sprdacs2="ssh ijps-sky18-product-ec2-ssl-acs2"
# alias sprdssl="ssh ijps-sky18-product-ec2-ssl-sky"
# 
# alias sprdxmpp01="ssh ijps-sky18-product-ec2-xmpp-01"
# alias sprdxmpp02="ssh ijps-sky18-product-ec2-xmpp-02"
# alias sprdxmpp03="ssh ijps-sky18-product-ec2-xmpp-03"
# alias sprdxmpp04="ssh ijps-sky18-product-ec2-xmpp-04"
# alias sprdxmpp05="ssh ijps-sky18-product-ec2-xmpp-05"
# alias sprdxmpp06="ssh ijps-sky18-product-ec2-xmpp-06"
# alias sprdxmpp07="ssh ijps-sky18-product-ec2-xmpp-07"
# alias sprdxmpp08="ssh ijps-sky18-product-ec2-xmpp-08"
# 
