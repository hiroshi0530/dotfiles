#!/bin/bash

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
jupyterthemep install jupyter_contrib_nbextensionss
        - https://qiita.com/woody-kawagoe/items/415c6f369ab2a6972ae6
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

