---
name: changelog
description: |
  CHANGELOG.md を更新する。
  ユーザーが「CHANGELOG 更新して」「変更履歴を書いて」「changelog を追加して」
  などと言った時に使用する。
---

# CHANGELOG 更新

コミット履歴・PR 情報をもとに [Keep a Changelog](https://keepachangelog.com/ja/1.0.0/) 形式で CHANGELOG.md を更新します。

## 使い方

- 「CHANGELOG 更新して」→ 前回タグから現在までの変更を追記
- 「v1.2.0 の CHANGELOG 書いて」→ 指定バージョンのセクションを作成
- 「Unreleased セクションを更新して」→ Unreleased に変更を追記

## 手順

### 1. CHANGELOG.md の確認

```bash
cat CHANGELOG.md 2>/dev/null || echo "CHANGELOG.md が存在しません"
```

存在しない場合は新規作成する（後述のフォーマット参照）。

### 2. 対象バージョン・範囲の特定

```bash
# 最新タグと現在の差分を確認
git --no-pager tag --sort=-version:refname | head -5
git --no-pager log <prev-tag>..HEAD --oneline --no-merges
```

タグがない場合は全コミットを対象にする。

### 3. PR・コミットの分類

各コミット・PR を以下のカテゴリに分類する：

| セクション | 内容 |
|-----------|------|
| **Added** | 新機能・新しい機能の追加 |
| **Changed** | 既存機能の変更・改善 |
| **Deprecated** | 近い将来削除予定の機能 |
| **Removed** | 削除された機能 |
| **Fixed** | バグ修正 |
| **Security** | セキュリティ修正 |

PR 情報を取得する場合：

```bash
gh pr list --state merged --base main --limit 30 --json number,title,mergedAt,labels
```

### 4. CHANGELOG エントリの作成

以下のフォーマットで記述する：

```markdown
## [<version>] - YYYY-MM-DD

### Added
- <新機能の説明> ([#<PR番号>](PR_URL))

### Changed
- <変更内容の説明> ([#<PR番号>](PR_URL))

### Fixed
- <修正内容の説明> ([#<PR番号>](PR_URL))

### Security
- <セキュリティ修正の説明>
```

#### 記述ルール

- 各項目は過去形ではなく現在形・命令形で（Added: "Add dark mode" ではなく "Dark mode support"）
- ユーザーへの影響が明確になるよう書く（技術的詳細より効果を重視）
- 空のセクション（該当なし）は省略する
- PR 番号は必ずリンク付きで記載する

### 5. Unreleased セクションの管理

リリース前の変更は `[Unreleased]` セクションにまとめる：

```markdown
## [Unreleased]

### Added
- ...
```

リリース時に `[Unreleased]` をバージョン番号に置き換える。

### 6. CHANGELOG.md の更新

新しいセクションを既存ファイルの先頭（ヘッダーの直後）に挿入する。

**基本フォーマット（新規作成時）:**

```markdown
# Changelog

このプロジェクトのすべての重要な変更はこのファイルに記録されます。

フォーマットは [Keep a Changelog](https://keepachangelog.com/ja/1.0.0/) に基づいており、
このプロジェクトは [Semantic Versioning](https://semver.org/lang/ja/) に準拠しています。

## [Unreleased]

## [x.y.z] - YYYY-MM-DD

### Added
- ...
```

### 7. ユーザー確認

更新内容をプレビュー表示し、ユーザーに確認してからファイルを更新する。

### 作成のポイント

- **ユーザー視点**: 開発者向けの実装詳細ではなく、利用者が「何が変わったか」を理解できるよう書く
- **Breaking Changes**: API 変更・後方非互換な変更は `Changed` や `Removed` にマークを付けて目立たせる
- **日付**: リリース日（マージ日ではない）を記載する
- **リンク**: ファイル末尾に比較 URL を記載すると便利：`[x.y.z]: https://github.com/owner/repo/compare/vA.B.C...vX.Y.Z`
