---
name: commit
description: |
  変更内容を解析して type・scope・subject を自動生成しコミットする。
  ユーザーが「コミットして」「変更をコミット」「commit して」
  などと言った時に使用する。
---

# Semantic Commit作成

ステージされた（またはすべての）変更を解析し、Conventional Commits 規約に従ったコミットメッセージを生成してコミットします。

## 使い方

- 「コミットして」→ ステージ済みの変更をコミット
- 「全部コミットして」→ `git add -A` してからコミット
- 「fix のコミットして」→ type を指定してコミット

## 手順

### 1. デフォルトブランチのチェック

```bash
# 現在のブランチを取得
current_branch=$(git branch --show-current)

# リポジトリのデフォルトブランチを取得（リモートがある場合）
default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||')
# リモートがない場合は main / master を確認
if [[ -z "$default_branch" ]]; then
  git show-ref --verify --quiet refs/heads/main && default_branch=main || default_branch=master
fi

echo "current: $current_branch / default: $default_branch"
```

現在のブランチがデフォルトブランチ（`main` / `master`）と一致する場合は **コミットを中断** し、ユーザーに以下を伝える：

```
現在のブランチはデフォルトブランチ（<branch-name>）です。
デフォルトブランチへの直接コミットは禁止されています。

feature ブランチを作成してから作業してください：
  git switch -c <type>/<description>
```

`branch` スキルを呼び出してブランチを作成するか確認してもよい。

### 2. 現在の状態確認

```bash
git status
git --no-pager diff --cached --stat
```

ステージされた変更がない場合は `git --no-pager diff --stat` で未ステージの変更を確認し、ユーザーに `git add` するか確認する。

### 2. 差分の詳細確認

```bash
git --no-pager diff --cached
```

変更の内容・目的・影響範囲を把握する。

### 3. コミットメッセージの生成

以下のフォーマットに従ってメッセージを生成する：

```
<type>(<scope>): <subject>

<body>  # 必要な場合のみ
```

#### type 一覧

| type | 用途 |
|------|------|
| feat | 新機能 |
| fix | バグ修正 |
| docs | ドキュメントのみの変更 |
| style | コードの意味に影響しない変更（空白、フォーマット等） |
| refactor | バグ修正・機能追加を伴わないコード変更 |
| test | テストの追加・修正 |
| chore | ビルドプロセスや補助ツールの変更 |
| ci | CI 設定の変更 |

#### ルール

- subject は命令形・現在形、英語なら50文字以内
- scope はディレクトリ名やモジュール名（省略可）
- 複数の変更がある場合は最も重要な type を選ぶ
- body は「何を」ではなく「なぜ」を書く（任意）
- 日本語リポジトリでは subject も日本語で構わない

### 4. ユーザー確認

生成したコミットメッセージをプレビュー表示し、ユーザーに確認する。

### 5. コミット実行

```bash
git commit -m "<type>(<scope>): <subject>" -m "<body（任意）>"
```

Co-authored-by トレーラーが必要な場合は `-m` を追加する：

```bash
git commit -m "<subject>" -m "<body>" -m "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

### 作成のポイント

- **subject**: 「何をしたか」を一言で。動詞から始める（Add / Fix / Update / Remove など）
- **scope**: 変更が局所的な場合に付ける（例: `feat(auth):`, `fix(api):`）
- **body**: 複雑な変更の背景や判断理由を説明。コミットログを読んだ人が意図を理解できるよう記載
- **Breaking Change**: フッターに `BREAKING CHANGE: <説明>` を追加する
