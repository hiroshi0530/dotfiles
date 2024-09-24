# .zprofile

# 環境変数を追加
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

append_path "${HOME}/.local/bin"

export PATH
