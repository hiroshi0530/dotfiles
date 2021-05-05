- クラウドのインスタンスにjupyter notebookをインストールする
- .jupyter.gcp をjupyter --path の直下におく

以下からGCPやPySparkの環境をインストール

- https://github.com/microsoft/recommenders/blob/main/SETUP.md
- jupyter notebook から使えるようにする

- kernelのuninstall 

```bash
$ jupyter kernelspec uninstall test
```

- cssとvim-bindingをインストール

```bash
$ pip install jupyter_contrib_nbextensions

# jupyter_contrib_nbextensionsのjavascript,cssをインストール
$ jupyter contrib nbextension install --user

拡張機能を置くディレクトリを作成
$ mkdir -p $(jupyter --data-dir)/nbextensions

そのディレクトリに移動
$ cd $(jupyter --data-dir)/nbextensions

vimをバインディングするパッケージjupyter-vim-bindingをgitでクローンしてくる
$ git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding

jupyter-vim-bindingを有効にする
$ jupyter nbextension enable vim_binding/vim_binding

設定を終えたらjupyter notebookでjupyterを起動して確認してみましょう。いい感じに使えるはずです。
```

- インストール後、cssを上書きする
