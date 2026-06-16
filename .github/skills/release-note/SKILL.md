---
name: release-note
description: |
  タグ間の差分からリリースの変更内容を整理して記述する。
  ユーザーが「リリースノートを作って」「ドラフトリリースを充実させて」「release note を書いて」
  などと言った時に使用する。
---

# リリースノート作成

GitHub のリリースドラフトを読み取り、PR の詳細を調査して充実したリリースノートを作成・更新する。

## 使い方

- タグ名を指定 → そのリリースを充実化
- 指定なし → 最新のドラフトリリースを充実化

## 手順

### 1. ドラフトリリースの特定

```bash
gh release list --limit 10
```

ユーザー指定のタグがあればそれを使用。なければ最新の Draft を使用。
ドラフトが見つからない場合はユーザーに報告して終了。

### 2. 現在のドラフト内容の取得

```bash
gh release view <tag> --json tagName,name,body,isDraft
```

ドラフトでない場合はユーザーに確認してから続行。

### 3. 前回リリースの特定

`gh release list` から、対象ドラフトの一つ前の Published リリースのタグを特定する。

### 4. 変更内容の収集

```bash
# コミット一覧
git log <prev-tag>...<target-tag> --oneline --no-merges

# 変更規模
git diff --shortstat <prev-tag>...<target-tag>
```

各コミットから PR 番号を抽出し、`gh pr view <number> --json title,body` で詳細を取得する。

### 5. リリースノートの作成

```markdown
## <tag>

<1〜2行のリリース概要>

## What's New

- <主要な変更を 3〜5 個ピックアップ>

## Features

- <タイトル> (<PR番号>): <内容>

## Bug Fixes

- <タイトル> (<PR番号>): <修正内容>

## Refactoring

- <タイトル> (<PR番号>): <内容>

## Breaking Changes（該当がある場合のみ）

- <破壊的変更の内容>

---

<N> files changed, <N> insertions(+), <N> deletions(-)

Full Changelog: <compare URL>
```

### 6. ユーザー確認

作成したリリースノートをプレビュー表示し、承認を得る。

### 7. ドラフト更新

```bash
gh release edit <tag> --notes "<content>"
```

## 作成のポイント

- What's New: 技術的な詳細より「何が嬉しいか」を伝える
- Features/Bug Fixes/Refactoring: PR body から要点を抽出。コミットメッセージのコピペ不可
- Breaking Changes: API 変更、コマンドの削除/リネーム、設定形式の変更など
- 自動生成ドラフトに漏れているコミット/PR がないか確認する
