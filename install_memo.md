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

