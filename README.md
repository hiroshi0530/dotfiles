# dotfiles

個人の開発環境設定を一元管理するリポジトリです。

## 構成

```
.
├── install.sh               # セットアップスクリプト
├── .bashrc                  # bash 設定 (.bashrc.d/ をロード)
├── .bashrc.d/               # bash モジュール設定
│   ├── 00-env.sh
│   ├── 10-history.sh
│   ├── 20-path.sh
│   ├── 30-terminal.sh
│   ├── 40-less.sh
│   ├── 50-completion.sh
│   ├── 60-prompt.sh
│   └── 70-tools.sh
├── .zshrc                   # zsh 設定 (.zshrc.d/ をロード)
├── .zshrc.d/                # zsh モジュール設定
│   ├── 00-options.zsh
│   ├── 10-env.zsh
│   ├── 20-history.zsh
│   ├── 30-path.zsh
│   ├── 40-less.zsh
│   ├── 50-completion.zsh
│   ├── 60-prompt.zsh
│   └── 70-tools.zsh
├── .gitconfig.local         # Git 設定 (install.sh が ~/.gitconfig にコピー)
├── .vimrc                   # Vim/Neovim 設定
├── .tmux.conf               # tmux 設定
├── .ideavimrc               # JetBrains IDE Vim エミュレーション設定
├── .github/
│   ├── copilot-instructions.md  # GitHub Copilot 指示書（全リポジトリで自動適用）
│   ├── prompts/                 # Copilot カスタムプロンプト（手動呼び出し）
│   └── workflows/               # GitHub Actions
├── vscode/
│   ├── settings.json        # VS Code 設定
│   ├── keybindings.json     # VS Code キーバインド
│   └── snippet/             # VS Code スニペット
├── jupyter/
│   ├── jupyter_notebook_config.py  # Jupyter 設定 (git管理用自動変換)
│   ├── custom.js            # Jupyter Vim キーバインド拡張
│   └── notebook.json        # Jupyter Notebook 設定
├── msshrc/
│   ├── connect.sh           # 複数ホストへの同時 SSH (tmux)
│   └── connect_k.sh         # k1〜k4 ホストへの一括接続
├── sshrc/                   # sshrc (リモート環境への設定持ち込み)
└── .sshrc.d/                # sshrc で読み込まれる設定
```

## 必要なツール

| ツール | 用途 | 必須 |
|--------|------|:----:|
| git | バージョン管理 | ✓ |
| vim / neovim | エディタ | ✓ |
| tmux | ターミナルマルチプレクサ | ✓ |
| zsh または bash | シェル | ✓ |
| direnv | ディレクトリ別環境変数 | |
| fzf | ファジー検索 | |
| autojump | ディレクトリジャンプ | |
| mise | ランタイムバージョン管理 | |
| pyenv | Python バージョン管理 | |
| nvm | Node.js バージョン管理 | |
| GitHub CLI (gh) | GitHub 認証・操作 | |

## セットアップ

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

ドライランで変更内容を確認してから実行することを推奨します:

```bash
./install.sh -n   # dry run (何も変更しない)
./install.sh      # 実際にインストール
```

### install.sh の処理内容

1. `.??*` にマッチする隠しファイル/ディレクトリを `$HOME` にシンボリックリンク
   - `.git`, `.DS_Store`, `.github`, `.codex` は除外
2. `.gitconfig.local` → `~/.gitconfig` にコピー
3. VS Code 設定を自動リンク (`settings.json`, `keybindings.json`, スニペット)
4. IPython Vim モードの有効化
5. `~/swap` (Vim スワップファイル用) ディレクトリ作成
6. `diff-highlight` のシンボリックリンク作成 (存在する場合)

## VS Code 拡張機能一覧の確認

```bash
code --list-extensions | xargs -L 1 echo code --install-extension
```

## Jupyter 設定

`jupyter/` 配下のファイルを `~/.jupyter/` に配置します:

```bash
cp jupyter/jupyter_notebook_config.py ~/.jupyter/
mkdir -p ~/.jupyter/custom
cp jupyter/custom.js ~/.jupyter/custom/
```

保存時に自動的に Markdown と Python スクリプトに変換し、出力をクリアします (Git 管理向け)。

## SSH 複数ホスト同時接続

```bash
# ホスト名を引数で渡す
bash msshrc/connect.sh host1 host2 host3

# k1〜k4 への一括接続
bash msshrc/connect_k.sh
```

tmux セッションが作成され、全 pane に同時入力できる sync モードで起動します。
