# 190115 aliasをvim :!コマンドから実行できるようにする
shopt -s expand_aliases

# file system 
function mkcd() { 
  mkdir $1 && cd $1
} 

# convert to snakecase to camelcase
function cc() {
  perl -pe 's#(_|^)(.)#\u$2#g'
}

# convert to camelcase to snakecase
function sc() {
  perl -pe 's#([A-Z])#_\L$1#g' | perl -pe 's#^_##'
}

