### 190710 mac set up memo

- anacondaのインストール
  - インストール後自動的にcondaの仮想環境ができてしまうので、.bash_profileなどから自動的に追記される設定を削除

- vim のbrewからのインストール
  - デフォルトでは vim --version | grep clipboard で -clipboard となる
  - ` brew install vim`でインストールすると、最新番のvimは以下の場所に配置される
  - /usr/local/Cellar/vim/8.1.1650/bin/vim --version | grep clip
  - vim, vimdiff, view, vimtutor の上記のパスに書き換える 
    - デフォルトで書き換わっている可能性あり

- direnv のインストール

  ```bash
    brew install direnv
  ```

- tmuxのインストール
  - tmux本体の前に、reattach-to-user-namespaceを入れる必要あり 

    ```python
      brew install reattach-to-user-namespace
      brew install tmux
    ```

  - go 

    ```bash
      brew install go
    ```

  - jupyter notebook

- git diff-highlight の有効化

- ワークスペース切り替えショートカットの設定

- default function key 設定変更

- autojumpのインストール
  - github 参照

- iterm color 設定
  - https://github.com/aereal/dotfiles.gitの japaneseque を利用



- pip install (適当に覚書）

  ```python
    pip install boto3
    pip install tensorflow
    pip install keras
    pip install jupyterlab
    pip install jupyterthemes
  ```

- jpyter notebook のvim化
  - jupyterthemesのインストール

    ```python
      pip install jupyterthemes
    ```

  - 色テーマとフォントの指定

    ```bash
      jt -t chesterish -T -f roboto -fs 9 -tf merriserif -tfs 11 -nf ptsans -nfs 11 -dfs 8 -ofs 8
    ```

    - install
      - 参考サイト
        - https://qiita.com/_snow_narcissus/items/80f81926707807ee9bf1 
        - https://qiita.com/woody-kawagoe/items/415c6f369ab2a6972ae6

```bash
jupyterの拡張機能を管理するパッケージjupyter_contrib_nbextensionsをインストール
$ pip install jupyter_contrib_nbextensions

jupyter_contrib_nbextensionsのjavascript,cssをインストール
$ jupyter contrib nbextension install --user

拡張機能を置くディレクトリを作成
$ mkdir -p $(jupyter --data-dir)/nbextensions

そのディレクトリに移動
$ cd $(jupyter --data-dir)/nbextensions

vimをバインディングするパッケージjupyter-vim-bindingをgitでクローンしてくる
$ git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding

jupyter-vim-bindingを有効にする
$ jupyter nbextension enable vim_binding/vim_binding
```

        - https://www.g104robo.com/entry/jupyter-notebook-vim
    
    - ./jupyter/custom.jsと./jupyter/custom.cssを~/.jupyter/custom/にコピー
      - normal modeに入った時の色や独自keybindを設定可能

    - jupyternotebookはgit管理用にpythonファイルを吐き出してくれるツールがあるのでそれをインストール
      - https://qiita.com/cfiken/items/8455383f32ee19dfbba3

      ```bash
        pip install jupytext
      ```

      - ./jupyter/jupyter_notebook_config.pyを~/.jupyter/にコピー 
        - ただし、shift-HKLのキーバインドが効かない


## 201125

- sshrcがbrewでインストール出来ない。githubからも消えている。このgitコミット済みのsshrc.zipを解凍してパスを通して利用する

## 210107 conda環境をjupyterから利用する

きっかけは、pystanが仮想環境でないと動かないこと（うまくやれればいけそう）

ただ、仮想環境をいくつか作っておくと、jupyter上からカーネルとして、それを選択できるのでとても使える

- https://qiita.com/Gyutan/items/c7d3c341efe09454a5e1

### 通常の仮想環境の構築

```bash
conda create -n stan python=3.6
conda activate stan
```

- 仮想環境上で必要なモジュールのインストール

```bash
conda install Cython Numpy pystan
conda install matplotlib jupyter scipy pandas
```

- 以下は必要であれば

```bash
conda install libpython m2w64-toolchain -c msys2

PYTHONPATH\\Lib\\distutils にある distutils.cfgに次のコマンドを付け加えます。

[build]
compiler=mingw32
```

### 仮想環境から出た後に、jupyterの設定

```bash
pip install environment_kernels
```

- 以下のファイルに、

```bash
~/.jupyter/jupyter_notebook_config.py
```

```text
c.NotebookApp.kernel_spec_manager_class='environment_kernels.EnvironmentKernelSpecManager'
c.EnvironmentKernelSpecManager.conda_env_dirs=['~/anaconda/envs']
```

を書き込む。参考サイトによるとconda_env_dirs => env_dirsだがdepericateみたい

