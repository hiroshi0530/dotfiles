# 基本
- 日本語で応答すること
- 不明点はユーザに質問して要求を明確にすること
- 作業後、作業内容とユーザが次に取れる行動を説明すること
- 作業項目が多い場合は段階に区切り、GitHub MCP で semantic commit を行いながら進めること
- コマンドの出力が確認できない場合、get last command / check background terminal を使用すること

## フェーズ定義

### 調査
- docs/reports/ に調査レポートを作成する
- 不明点は fetch MCP・context7 MCP で検索する

### 計画
- docs/tasks.md に計画を記載する（前回の内容は消して構わない）
- コードベースと docs を読み込み、要件に関連するファイルパスをすべて記載する
- 不明点は fetch MCP・context7 MCP で検索する
- 必要最小限の要件のみ記載する
- **このフェーズでコードを書いてはいけない**

### 実装
- docs/tasks.md の記載範囲のみ実装する（それ以上は絶対に書かない）
- デバッグしない

### デバッグ
- 直前のタスクのデバッグ「手順」のみ示す

## ドキュメント構造
- docs/reports/*.md : 調査レポート
- docs/tasks.md : 実装計画
- docs/schema.md : データ構造
- docs/requirements.md : 要件定義
