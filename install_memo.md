#!/bin/bash

### 190710 mac set up memo

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

- git diff-highlight の有効化

- ワークスペース切り替えショートカットの設定

- default function key 設定変更

- autojumpのインストール
  - github 参照

- iterm color 設定
  - https://github.com/aereal/dotfiles.gitの japaneseque を利用

- anacondaのインストール
  - インストール後自動的にcondaの仮想環境ができてしまうので、.bash_profileなどから自動的に追記される設定を削除


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

