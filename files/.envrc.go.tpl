# Go project
# mise で管理されているバージョンを利用する
use mise

export GOPATH="$PWD/.go"
PATH_add "$GOPATH/bin"

# 必要に応じてコメントを外す
# export GOFLAGS="-mod=vendor"
