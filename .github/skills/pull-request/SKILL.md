---
name: pull-request
description: |
  差分を解析してタイトル・本文・チェックリストを含む PR を作成する。
  ユーザーが「PR を作って」「プルリクを出して」「pull request を作成して」
  などと言った時に使用する。
---

# Pull Request 作成

現在のブランチの変更を調査し、適切なタイトル・本文で PR を作成します。

## 使い方

- 「PR を作って」→ 現在のブランチで PR を作成
- 「draft PR を作って」→ ドラフト PR を作成
- 「#123 に向けて PR を作って」→ 特定 Issue に紐づけた PR を作成

## 手順

### 1. 現在の状態確認

```bash
git status
git --no-pager log main..HEAD --oneline
```

未コミットの変更がある場合はユーザーに確認してから続行。

**デフォルトブランチにいる場合は新しいブランチを作成する。**

現在のブランチがデフォルトブランチ（`main` / `master`）と一致する場合は、
コミット内容から適切なブランチ名を生成して切り替えてから PR を作成する。

```bash
# デフォルトブランチの確認
default_branch=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name')
current_branch=$(git branch --show-current)

# デフォルトブランチにいる場合は新ブランチを作成
if [ "$current_branch" = "$default_branch" ]; then
  # コミット内容から <type>/<short-description> 形式でブランチ名を決める
  git checkout -b <type>/<short-description>
fi
```

ブランチ名の命名規則: `<type>/<kebab-case-description>`
例: `feat/add-mise-config`、`fix/bash-display-guard`、`docs/update-readme`

### 2. 差分の調査

```bash
git --no-pager diff main...HEAD --stat
git --no-pager diff main...HEAD
```

変更の目的・影響範囲を把握する。

### 3. 関連 Issue の確認

ブランチ名やコミットメッセージから関連 Issue 番号を抽出する。

```bash
gh issue list --state open --limit 20
```

### 4. PR タイトル・本文の作成

以下のテンプレートに従って PR 本文を作成する:

```markdown
## 概要
<このPRで行った変更の1〜2行サマリー>

## 関連Issue
Closes #<番号>

## 変更内容
- [ ] 機能追加
- [ ] バグ修正
- [ ] リファクタリング
- [ ] ドキュメント更新

## 修正詳細
- <具体的な変更点を箇条書き>

## レビューのポイント
<特に見てほしい箇所や相談事項>

## チェックリスト
- [ ] 自分のコードの自己レビューを完了した
- [ ] 必要な箇所にコメントを入れた
- [ ] テストを追加した
- [ ] 新しい機能はドキュメントを更新した
```

**タイトルの命名規則**: `<type>: <概要>` 形式（例: `feat: ユーザー認証機能を追加`）
- `feat` / `fix` / `refactor` / `docs` / `chore` / `test`

### 5. ユーザー確認

作成予定の PR タイトルと本文をプレビュー表示し、ユーザーに確認する。

### 6. PR 作成

```bash
# 通常PR
gh pr create --title "<タイトル>" --body "<本文>" --base main

# ドラフトPR
gh pr create --title "<タイトル>" --body "<本文>" --base main --draft

# Issue に紐づける場合（本文に Closes #番号 を含めれば自動でリンク）
```

### 作成のポイント

- **タイトル**: 変更の目的を端的に表現。日本語 or 英語はリポジトリの既存 PR に合わせる
- **概要**: レビュアーが変更の背景をすぐ理解できるよう記載
- **変更内容**: チェックボックスで変更種別を明示
- **修正詳細**: コミットメッセージのコピペではなく、内容を理解して説明する
- **レビューのポイント**: 設計上の判断や迷った点があれば積極的に記載
