---
name: readme-sync
description: |
  コードの変更に追随して README の該当セクションを書き直す。
  ユーザーが「READMEを更新して」「ドキュメントを直して」「READMEに反映して」
  などと言った時に使用する。
---

# README更新

コードの変更内容を解析し、READMEの対応するセクションを自動更新します。

## 使い方

- 「READMEを更新して」→ 現在の差分に基づいてREADMEを更新
- 「新機能をREADMEに追記して」→ 追加された機能をドキュメントに反映
- 「APIの変更をREADMEに反映して」→ インターフェース変更を反映

## 手順

### 1. 変更内容の把握

```bash
# コードの差分を確認
git --no-pager diff main...HEAD --stat
git --no-pager diff main...HEAD
```

変更の種類を分類する：
- 新機能の追加
- 既存機能の変更（APIシグネチャ・設定値など）
- 機能の削除・非推奨化
- インストール手順・環境要件の変更

### 2. 現在のREADMEを読み込む

```bash
cat README.md
```

READMEの構成を把握し、更新が必要なセクションを特定する。

### 3. 更新が必要なセクションの特定

| 変更種別 | 更新対象セクション |
|---------|-----------------|
| 新機能追加 | Features / Usage / API Reference |
| 設定変更 | Configuration / Environment Variables |
| インターフェース変更 | API Reference / Usage Examples |
| 依存関係変更 | Installation / Requirements |
| 破壊的変更 | Migration Guide / BREAKING CHANGES |
| バグ修正 | 通常は不要（CHANGELOGへ） |

### 4. READMEの更新

以下のルールに従って更新する：

#### 書き方の原則

- **簡潔に**: 長い説明より短い例を優先する
- **動作するコード例**: コピー&ペーストで動くサンプルを書く
- **バージョン明記**: 変更がバージョン依存の場合は明記する
- **既存スタイルに合わせる**: 文体・見出しレベル・コードブロック言語を統一する

#### セクション別の更新内容

**Installation / Setup**
```markdown
## インストール

```bash
npm install <package-name>@<version>
```
```

**Usage / Getting Started**
- 最小限の動作例を最初に示す
- オプション・設定は後のセクションで説明

**API Reference / Configuration**
- 変更・追加されたプロパティ・メソッドを反映
- 削除された項目は `**Deprecated**` を付けるか削除

**Breaking Changes（破壊的変更の場合）**
```markdown
## v2.0 からの移行

### 変更点

| 旧 | 新 |
|---|---|
| `oldOption` | `newOption` |
```

### 5. 更新内容のプレビュー

更新後のREADMEをプレビュー表示し、ユーザーに確認を求めてから適用する。
