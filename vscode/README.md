#### vscode setting
- 以下のサイトを参考にして拡張機能を入れる
  https://qiita.com/sensuikan1973/items/74cf5383c02dbcd82234

#### vscode vi setting
- パレットからvimのプラグインをインストール。vimの名前がついたものは色々あるけど、vimそのままのもの
- settings.jsonを ~/Library/Application Support/Code/User/ にエイリアスをつける
  - これでdotfileのsettingが読み込める

- keybindings.jsonも同様 ~/Library/Application Support/Code/User/ にエイリアスをつける
 
- 二つのjsonもdotfilesを更新する

#### 拡張機能一覧を表示するコマンド

    ```bash
      code --list-extensions | xargs -L 1 echo code --install-extension
    ```

####  2019年 9月25日 水曜日 17時27分20秒 JST
##### vs code snipettをgit管理とする

- typescript.jsonも同様 ~/Library/Application Support/Code/User/snippet/ にエイリアスをつける

