# セットアップメモ

> 基本的なセットアップ手順は [README.md](README.md) を参照。
> このファイルにはツール別の補足メモを記載する。

---

## TeX / LaTeX

```bash
brew install mactex-no-gui --cask
```

- VS Code 拡張: LaTeX Workshop
- `.latexmkrc` と `vscode/keybindings.json` はシンボリックリンクで自動反映

---

## Python 環境

mise でバージョンを管理する:

```bash
mise install  # python = "3.12" がインストールされる
```

conda/anaconda を使う場合は mise Python との競合に注意。
`.bashrc.d/20-path.sh` および `.zshrc.d/30-path.zsh` では anaconda3/bin は PATH に含めていない。

---

## Git

デフォルトの Git はバージョンが古いため、必ず brew でインストールする:

```bash
brew install git
```

---

## Vim (clipboard 対応)

デフォルトの Vim は `-clipboard`。brew 版を使う:

```bash
brew install vim
```

---

## direnv

```bash
brew install direnv
```

---

## tmux

```bash
brew install reattach-to-user-namespace
brew install tmux
```

---

## git diff-highlight

`install.sh` が自動リンクを試みる。手動でリンクする場合:

```bash
DIFF_HIGHLIGHT_SRC=/usr/local/share/git-core/contrib/diff-highlight/diff-highlight
ln -s "$DIFF_HIGHLIGHT_SRC" /usr/local/bin/diff-highlight
```

---

## autojump

GitHub リポジトリの指示に従いインストール: https://github.com/wting/autojump

---

## iTerm2

カラースキーム: `iterm.json` をプロファイルとしてインポート。

---

## Jupyter Notebook

```bash
pip install jupyterlab jupyterthemes jupytext jupyter_contrib_nbextensions environment_kernels
```

設定ファイルを配置:

```bash
cp jupyter/jupyter_notebook_config.py ~/.jupyter/
mkdir -p ~/.jupyter/custom
cp jupyter/custom.js ~/.jupyter/custom/
```

Vim バインディング拡張:

```bash
cd "$(jupyter --data-dir)/nbextensions"
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
jupyter nbextension enable vim_binding/vim_binding
```

### conda 仮想環境を Jupyter カーネルとして使う

```bash
conda create -n myenv python=3.11
conda activate myenv
conda install jupyter ipykernel
```

`~/.jupyter/jupyter_notebook_config.py` に追記:

```python
c.NotebookApp.kernel_spec_manager_class = 'environment_kernels.EnvironmentKernelSpecManager'
c.EnvironmentKernelSpecManager.conda_env_dirs = ['~/anaconda3/envs']
```

---

## sshrc

`sshrc/` 配下の `sshrc.zip` を解凍してパスを通す (brew では入手不可):

```bash
cd sshrc
unzip sshrc.zip -d bin/
export PATH="$PATH:$PWD/bin"
```

---

## pip パッケージ例

```bash
pip install boto3 tensorflow keras jupyterlab jupyterthemes
```


