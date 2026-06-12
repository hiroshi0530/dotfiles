---
name: branch
description: |
  命名規則に従ったブランチを作成して切り替える。
  ユーザーが「ブランチ切って」「ブランチ作って」「feature branch を作って」
  などと言った時に使用する。
---

# 🌿 ブランチ作成

Issue 番号・変更種別・内容に応じた命名規則でブランチを作成し、切り替えます。

## 使い方

- 「ブランチ切って」→ 内容をヒアリングしてブランチ作成
- 「#123 のブランチ作って」→ Issue に紐づいたブランチ作成
- 「fix/ログインバグのブランチ作って」→ 指定した名前でブランチ作成

## 手順

### 1. 現在の状態確認

```bash
git status
git --no-pager branch --show-current
```

未コミットの変更がある場合はユーザーに確認してから続行。

### 2. ベースブランチの確認

```bash
git --no-pager branch -a | head -20
```

通常は `main` または `master` をベースにする。別のブランチが指定されている場合はそちらを使用。

### 3. ブランチ名の決定

以下の命名規則に従ってブランチ名を生成する：

```
<type>/<issue-number>-<short-description>
```

| type | 用途 |
|------|------|
| feat | 新機能 |
| fix | バグ修正 |
| docs | ドキュメント |
| refactor | リファクタリング |
| test | テスト追加・修正 |
| chore | 設定・ツール変更 |
| hotfix | 緊急修正 |

#### 命名ルール

- すべて小文字
- スペースはハイフン `-` に置換
- 英単語を推奨（日本語リポジトリでも英語ブランチ名が一般的）
- 短く・意味が伝わるよう（3〜5単語程度）
- Issue 番号があれば必ず含める

#### 例

```
feat/123-add-dark-mode
fix/456-login-500-error
docs/update-readme
refactor/auth-module
hotfix/security-patch
```

### 4. ユーザー確認

提案するブランチ名を表示し、ユーザーに確認する。

### 5. ブランチ作成・切り替え

```bash
# リモートの最新を取得してからブランチ作成
git fetch origin
git checkout -b <branch-name> origin/main
```

または main が既にローカルに存在する場合：

```bash
git checkout main && git pull
git checkout -b <branch-name>
```

### 6. 確認

```bash
git --no-pager branch --show-current
```

### 作成のポイント

- **Issue 番号**: 関連 Issue があれば必ず含める（PR で自動リンクされる）
- **短縮説明**: `add-user-auth` のように動詞 + 名詞の形が読みやすい
- **type プレフィックス**: GitHub の PR 一覧でフィルタしやすくなる
