# セットアップメモ

> 基本的なセットアップ手順は [README.md](README.md) を参照。
> このファイルにはツール別の補足メモを記載する。

---

## Python 環境

mise でバージョンを管理する:

```bash
mise install  # python = "3.12" がインストールされる
```

`.bashrc.d/20-path.sh` および `.zshrc.d/30-path.zsh` で PATH を管理しているため、他のバージョン管理ツールとの競合に注意。

---

## TeX / LaTeX

### macOS

```bash
brew install mactex-no-gui --cask
```

### Linux (ArchLinux)

```bash
sudo pacman -S texlive-most texlive-lang
```

VS Code 拡張: LaTeX Workshop

---

## Git

### macOS

デフォルトの Git はバージョンが古いため、brew でインストール:

```bash
brew install git
```

### Linux (ArchLinux)

```bash
sudo pacman -S git
```

---

## Vim (clipboard 対応)

### macOS

デフォルトの Vim は `-clipboard`。brew 版を使う:

```bash
brew install vim
```

### Linux (ArchLinux)

```bash
sudo pacman -S vim gvim
```

---

## autojump

### macOS

GitHub リポジトリの指示に従いインストール: https://github.com/wting/autojump

### Linux (ArchLinux)

```bash
sudo pacman -S autojump
```

シェル rc ファイルに以下を追加:

```bash
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
```

---

## git diff-highlight

`install.sh` が自動リンクを試みる。手動でリンクする場合:

```bash
DIFF_HIGHLIGHT_SRC=/usr/local/share/git-core/contrib/diff-highlight/diff-highlight
ln -s "$DIFF_HIGHLIGHT_SRC" /usr/local/bin/diff-highlight
```

---

## Jupyter Notebook

```bash
pip install jupyterlab jupyterthemes jupytext
```

設定ファイルを配置:

```bash
cp jupyter/jupyter_notebook_config.py ~/.jupyter/
mkdir -p ~/.jupyter/custom
cp jupyter/custom.js ~/.jupyter/custom/
```

詳細な設定は [README.md](README.md#jupyter-%E8%A8%AD%E5%AE%9A) を参照。

---

## sshrc

`sshrc/` 配下の `sshrc.zip` を解凍してパスを通す:

```bash
cd sshrc
unzip sshrc.zip -d bin/
export PATH="$PATH:$PWD/bin"
```
