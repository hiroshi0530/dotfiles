# dotfiles

個人の開発環境設定を一元管理するリポジトリです。

## ディレクトリ構成

```
.
├── install.sh               # セットアップスクリプト（symlink・パッケージ・ツール一括設定）
├── packages/                # OS 別パッケージリスト（宣言的管理）
│   ├── pacman.txt           #   Arch Linux
│   ├── apt.txt              #   Ubuntu / Debian
│   ├── brew.txt             #   macOS (brew install)
│   └── brew-cask.txt        #   macOS (brew install --cask)
├── bin/                     # 個人スクリプト（install.sh が ~/bin に symlink）
│   └── tmux-sessionizer     #   ghq + fzf でプロジェクト選択 → tmux session 接続
├── files/                   # テンプレート類（symlink 対象外）
│   ├── .envrc.python.tpl    #   direnv テンプレート: Python
│   ├── .envrc.node.tpl      #   direnv テンプレート: Node.js
│   ├── .envrc.go.tpl        #   direnv テンプレート: Go
│   └── .envrc.rust.tpl      #   direnv テンプレート: Rust
├── .bashrc                  # bash 設定 (.bashrc.d/ をロード)
├── .bashrc.d/               # bash モジュール設定
├── .zshrc                   # zsh 設定 (.zshrc.d/ をロード)
├── .zshrc.d/                # zsh モジュール設定
│   ├── 30-path.zsh          #   PATH 管理（重複排除）
│   └── 70-tools.zsh         #   mise / fzf / zoxide / direnv / tmux-sessionizer
├── .vimrc                   # Vim/Neovim 共通設定（~/.config/nvim/init.vim に symlink）
├── .config/
│   ├── nvim/
│   │   ├── os/              #   OS 別 Neovim 設定
│   │   │   ├── mac.vim      #     macOS: clipboard 設定
│   │   │   ├── wsl.vim      #     WSL2: win32yank クリップボード設定
│   │   │   └── linux.vim    #     Linux: 拡張用
│   │   └── .gitignore       #   plugged/ pack/ を git 除外
│   ├── mise/
│   │   └── config.toml      #   mise 管理ツール一覧
│   ├── sheldon/
│   │   └── plugins.toml     #   zsh プラグインマネージャ設定
│   └── atuin/
│       └── config.toml      #   シェル履歴管理設定
├── .gitconfig.local         # Git 設定（install.sh が ~/.gitconfig にコピー）
├── .tmux.conf               # tmux 設定
├── .tigrc                   # tig 設定
├── .github/
│   ├── copilot-instructions.md  # GitHub Copilot 指示書（全リポジトリで自動適用）
│   ├── prompts/                 # Copilot カスタムプロンプト
│   └── workflows/               # GitHub Actions
├── vscode/
│   ├── settings.json        # VS Code 設定
│   ├── keybindings.json     # VS Code キーバインド
│   └── snippet/             # VS Code スニペット
├── jupyter/                 # Jupyter Notebook 設定
├── msshrc/                  # 複数ホスト同時 SSH（tmux）
├── sshrc/                   # リモート環境への設定持ち込み（sshrc 本体）
├── .sshrc                   # sshrc が参照する設定（install.sh が $HOME に symlink）
└── .sshrc.d/                # sshrc で読み込まれる設定（install.sh が $HOME に symlink）
```

## セットアップ

```bash
git clone https://github.com/hiroshi0530/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh -n   # dry run（何も変更しない）
./install.sh      # 実際にインストール
```

### install.sh の処理内容

| ステップ | 内容 |
|---|---|
| OS パッケージ | `packages/*.txt` を参照し pacman / apt / brew で一括インストール |
| dotfiles symlink | `.??*` の隠しファイル/ディレクトリを `$HOME` に symlink（`.git` `.DS_Store` `.github` `.codex` `.config` 除外） |
| bin/ symlink | `bin/*` を `~/bin/` に symlink |
| Neovim | `~/.config/nvim/init.vim -> .vimrc`、`~/.config/nvim/os -> .config/nvim/os` を symlink |
| mise | `~/.config/mise/config.toml` を symlink |
| sheldon | `~/.config/sheldon/plugins.toml` を symlink |
| atuin | `~/.config/atuin/config.toml` を symlink |
| VS Code | `settings.json` / `keybindings.json` / スニペット / Copilot プロンプトを symlink |
| .gitconfig | `.gitconfig.local` を `~/.gitconfig` にコピー |
| IPython | `~/.ipython/.../ipython_config.py` を作成し Vim 編集モードを有効化 |
| swap | `~/swap` を作成（Vim swap 用） |
| .github | `~/.github -> .github` を symlink（Copilot 指示書） |
| Copilot CLI skills | `~/.copilot/skills/*` を symlink |
| diff-highlight | 条件を満たす場合 `diff-highlight` を `/usr/local/bin` に symlink |
| GitHub CLI 拡張 | `gh-dash`（PR/Issue ダッシュボード）/ `gh-markdown-preview` をインストール |
| mise install | `config.toml` に記載されたツールを一括インストール |

### インストール時の注意点

**WSL2 環境**

- `packages/pacman.txt` の `docker` は Docker Desktop（Windows 側）を使う場合は不要
- Nerd Font は Linux 内ではなく **Windows 側にインストール**する必要がある（Windows Terminal で使用する場合）
- Neovim のクリップボード連携は `win32yank.exe` 経由（`.config/nvim/os/wsl.vim`）

**Neovim プラグイン**

install.sh 実行後、初回のみ以下を実行:

```bash
nvim +PlugInstall +qall
```

`plugged/`（vim-plug）と `pack/`（Neovim 標準パッケージで導入したプラグイン）は `.gitignore` 対象のため自動生成される。

**Nerd Font（WSL2 / Windows Terminal）**

PowerShell で Windows 側にインストール:

```powershell
Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip" -OutFile "$env:TEMP\Hack.zip"
Expand-Archive "$env:TEMP\Hack.zip" -DestinationPath "$env:TEMP\HackNF" -Force
$fontDest = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
New-Item -ItemType Directory -Force -Path $fontDest | Out-Null
$regPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
Get-ChildItem "$env:TEMP\HackNF\*.ttf" | ForEach-Object {
    Copy-Item $_.FullName $fontDest -Force
    Set-ItemProperty -Path $regPath -Name "$([System.IO.Path]::GetFileNameWithoutExtension($_.Name)) (TrueType)" -Value "$fontDest\$($_.Name)"
}
```

Windows Terminal の `settings.json` にフォントを設定:

```json
{
  "profiles": {
    "defaults": {
      "font": { "face": "Hack Nerd Font Mono" }
    }
  }
}
```

## mise で管理するツール

`~/.config/mise/config.toml` で宣言的に管理。`mise install` で一括インストール。

| カテゴリ | ツール |
|---|---|
| 言語 | python / node / go / rust |
| CLI ツール | neovim / tmux / bat / fd / delta / ripgrep / zoxide |
| Git 関連 | lazygit / lazydocker |
| シェル補助 | sheldon / atuin |
| インフラ | kubectl / awscli / hurl |

## direnv テンプレート

プロジェクト用の `.envrc` をテンプレートから生成できる:

```bash
cd ~/projects/my-app
envrc-new python   # python / node / go / rust から選択
da                 # direnv allow で有効化
```

テンプレートは `files/.envrc.*.tpl` に格納。

## tmux-sessionizer

`Ctrl+F` でプロジェクト一覧（ghq 管理リポジトリ）を fzf で選択し、tmux session に自動接続:

```bash
# 前提: ghq で管理されているリポジトリが対象
tmux-sessionizer          # fzf でプロジェクト選択
tmux-sessionizer <path>   # パスを直接指定
```

## SSH 複数ホスト同時接続

```bash
bash msshrc/connect.sh host1 host2 host3   # 複数ホストに同時接続
bash msshrc/connect_k.sh                   # k1〜k4 への一括接続
```

tmux セッションが作成され、全 pane に同時入力できる sync モードで起動する。

## Jupyter 設定

```bash
cp jupyter/jupyter_notebook_config.py ~/.jupyter/
mkdir -p ~/.jupyter/custom
cp jupyter/custom.js ~/.jupyter/custom/
```

保存時に自動で Markdown / Python スクリプトに変換し、出力をクリアする（Git 管理向け）。

## VS Code 拡張機能一覧の確認

```bash
code --list-extensions | xargs -L 1 echo code --install-extension
```

