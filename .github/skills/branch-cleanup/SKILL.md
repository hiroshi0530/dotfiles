---
name: branch-cleanup
description: |
  統合済みの不要ブランチを一括で整理する。
  ユーザーが「マージ済みブランチを削除して」「ブランチを掃除して」「不要なブランチを消して」
  などと言った時に使用する。
---

# マージ済みブランチのクリーンアップ

リモートにマージ済みのブランチをローカル・追跡ブランチから安全に削除します。

## 使い方

- 「マージ済みブランチを削除して」→ マージ済みブランチを一括削除
- 「ブランチを掃除して」→ 不要なブランチを検出して削除
- 「特定のブランチを削除して」→ 指定ブランチのみ削除

## 手順

### 1. 現在の状態確認

```bash
# 現在のブランチを確認（誤って削除しないようにする）
git branch --show-current

# デフォルトブランチを確認
default_branch=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name' 2>/dev/null || echo "master")
echo "default branch: $default_branch"
```

### 2. リモートの最新情報を取得

```bash
# リモートの削除済みブランチを追跡ブランチからも除去しながらフェッチ
git fetch --prune
```

`--prune` オプションにより、リモートで削除済みの追跡ブランチ（`origin/*`）が自動的に削除される。

### 3. マージ済みブランチの一覧表示

```bash
# ローカルのマージ済みブランチ（デフォルトブランチ・現在ブランチを除く）
git branch --merged "${default_branch}" \
  | grep -v "^\*" \
  | grep -v "^\s*${default_branch}$" \
  | grep -v "^\s*master$" \
  | grep -v "^\s*main$"
```

削除対象のブランチ一覧をユーザーに提示し、確認を求める。

### 4. ローカルブランチの削除

確認後、マージ済みブランチを削除する：

```bash
# 一括削除
git branch --merged "${default_branch}" \
  | grep -v "^\*" \
  | grep -v "^\s*${default_branch}$" \
  | grep -v "^\s*master$" \
  | grep -v "^\s*main$" \
  | xargs -r git branch -d
```

`-d`（`--delete`）はマージ済みブランチのみ削除するため、未マージブランチは保護される。

⚠️ `-D`（強制削除）は**ユーザーが明示的に指示した場合のみ**使用する。

### 5. 追跡ブランチ（remote-tracking refs）の確認

`git fetch --prune`（手順2）で通常は処理されるが、残っている場合は手動で削除する：

```bash
# 残存する追跡ブランチを確認
git branch -r | grep -v HEAD

# リモートで削除済みの追跡ブランチをまとめて除去
git remote prune origin
```

### 6. 削除後の確認

```bash
# 残っているブランチを確認
git branch -a
```

### よくあるパターン

#### 特定ブランチのみ削除

```bash
git branch -d <branch-name>
# 追跡ブランチも削除（リモートでも削除したい場合）
git push origin --delete <branch-name>
```

#### GitHub CLI でマージ済みPRのブランチを確認

```bash
# マージ済みPRのヘッドブランチ一覧
gh pr list --state merged --limit 20 --json headRefName --jq '.[].headRefName'
```

### 注意事項

- `master` / `main` / `develop` / `merge-worktrees` などの長期ブランチは削除しない
- 現在チェックアウト中のブランチは削除できない（自動的にスキップされる）
- `--merged` は指定ブランチへのマージ済みかどうかで判定するため、デフォルトブランチを正しく指定すること
- リモートブランチ（`origin/<branch>`）の削除は**ユーザーに確認してから**実行する
