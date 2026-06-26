---
name: pull-request
description: |
  差分を解析してタイトル・本文・チェックリストを含む PR を作成する。
  ユーザーが「PR を作って」「プルリクを出して」「pull request を作成して」
  などと明示的に指示した時のみ使用する。
  指示がない場合は自動で呼び出さない。
---

# Pull Request 作成

現在のブランチの変更を調査し、適切なタイトル・本文で PR を作成します。

> **このスキルはユーザーから明示的に「PR を作って」と指示があった場合のみ実行する。**
> commit・push の完了後に自動で呼び出さない。

## 使い方

- 「PR を作って」→ 現在のブランチで PR を作成
- 「draft PR を作って」→ ドラフト PR を作成
- 「#123 に向けて PR を作って」→ 特定 Issue に紐づけた PR を作成

## 手順

### 1. 現在の状態確認

```bash
# merge-worktrees とデフォルトブランチの差分を確認
git fetch origin
git --no-pager log origin/master..origin/merge-worktrees --oneline
git --no-pager diff origin/master...origin/merge-worktrees --stat
```

PR は常に **`merge-worktrees` → `master`** で作成する。
feature ブランチから直接 PR を作成しない。

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
# merge-worktrees -> master への PR
gh pr create \
  --base master \
  --head merge-worktrees \
  --title "<タイトル>" \
  --body "<本文>"

# ドラフトPR
gh pr create \
  --base master \
  --head merge-worktrees \
  --title "<タイトル>" \
  --body "<本文>" \
  --draft
```

### 7. マージはユーザーが行う

PR を作成した後、**マージは絶対に自動で行わない**。

- `gh pr merge` を勝手に実行しない
- CI の完了を待って自動マージ（`--auto`）も使用しない
- PR の URL をユーザーに伝え、マージはユーザー自身に委ねる

```
PR を作成しました: https://github.com/<owner>/<repo>/pull/<number>

CI が通ったことを確認後、マージをお願いします。
```

### 作成のポイント

- **タイトル**: 変更の目的を端的に表現。日本語 or 英語はリポジトリの既存 PR に合わせる
- **概要**: レビュアーが変更の背景をすぐ理解できるよう記載
- **変更内容**: チェックボックスで変更種別を明示
- **修正詳細**: コミットメッセージのコピペではなく、内容を理解して説明する
- **レビューのポイント**: 設計上の判断や迷った点があれば積極的に記載
