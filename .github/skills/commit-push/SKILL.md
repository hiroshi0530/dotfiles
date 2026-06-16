---
name: commit-push
description: |
  変更をステージングして semantic commit を作成し、リモートにプッシュする。
  ユーザーが「コミットしてプッシュして」「コミット&プッシュ」「push まで一気にやって」
  などと言った時に使用する。
---

# Semantic Commit & Push

変更を解析し、Conventional Commits 規約に従ったコミットメッセージを生成してコミット後、リモートへプッシュします。

## 使い方

- 「コミットしてプッシュして」→ ステージ済みの変更をコミット＆プッシュ
- 「全部コミットしてプッシュして」→ `git add -A` してからコミット＆プッシュ
- 「push まで一気にやって」→ コミットメッセージ確認後にプッシュまで実行

## 手順

### 1. 現在の状態確認

```bash
git status
git --no-pager diff --cached --stat
```

ステージされた変更がない場合は未ステージの変更を確認する：

```bash
git --no-pager diff --stat
```

未ステージの変更がある場合は `git add -A` するかユーザーに確認する。

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

### 4. プッシュ先の確認

```bash
# 現在のブランチ名を確認
git branch --show-current

# リモートの設定を確認
git remote -v

# リモートとの差分を確認（上流ブランチがある場合）
git --no-pager log @{u}..HEAD --oneline 2>/dev/null || echo "上流ブランチ未設定"
```

### 5. ユーザー確認

生成したコミットメッセージとプッシュ先をプレビュー表示し、確認を求める：

```
コミットメッセージ:
  feat(skills): add commit-push skill

プッシュ先:
  origin/<branch-name>

実行しますか？ [y/N]
```

### 6. コミット実行

```bash
git commit -m "<type>(<scope>): <subject>" -m "<body（任意）>"
```

Co-authored-by トレーラーが必要な場合：

```bash
git commit -m "<subject>" -m "<body>" -m "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

### 7. プッシュ実行

```bash
# 通常のプッシュ
git push origin <branch-name>

# 上流ブランチが未設定の場合（新規ブランチ）
git push --set-upstream origin <branch-name>
```

#### プッシュ失敗時の対処

```bash
# リモートに新しいコミットがある場合（非破壊的な解決）
git pull --rebase origin <branch-name>
git push origin <branch-name>
```

⚠️ `--force` / `--force-with-lease` はユーザーに明示的に確認を取った場合のみ使用する。

### 作成のポイント

- **subject**: 「何をしたか」を一言で。動詞から始める（Add / Fix / Update / Remove など）
- **scope**: 変更が局所的な場合に付ける（例: `feat(auth):`, `fix(api):`）
- **body**: 複雑な変更の背景や判断理由を説明
- **Breaking Change**: フッターに `BREAKING CHANGE: <説明>` を追加する
- **force push 禁止**: `main` / `master` へのforce pushは絶対に行わない
