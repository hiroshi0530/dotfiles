---
name: naming-review
description: |
  コードの命名規則（変数・関数・クラス名など）の統一性をチェックする。
  ユーザーが「命名確認して」「変数名を見て」「naming チェックして」
  などと言った時に使用する。
---

# 命名規則レビュー

コードの変数・関数・クラス・ファイル名を解析し、命名規則の違反・一貫性のなさ・意図が伝わらない名前を指摘します。

## 使い方

- 「命名確認して」→ 現在の差分をチェック
- 「このファイルの命名を見て」→ 指定ファイルをチェック
- 「変数名が適切か確認して」→ 命名の質に絞ってチェック

## 手順

### 1. 対象コードと言語の確認

```bash
# 差分を確認
git --no-pager diff main...HEAD --stat
git --no-pager diff main...HEAD
```

言語ごとのデフォルト規則を把握する：

| 言語 | 変数/関数 | クラス | 定数 | ファイル |
|------|-----------|--------|------|----------|
| TypeScript/JavaScript | camelCase | PascalCase | UPPER_SNAKE | kebab-case |
| Python | snake_case | PascalCase | UPPER_SNAKE | snake_case |
| Go | camelCase / PascalCase（公開） | PascalCase | PascalCase | snake_case |
| Ruby | snake_case | PascalCase | UPPER_SNAKE | snake_case |

### 2. 既存コードの規則を把握

既存コードがある場合は、プロジェクト独自の規則を優先する：

```bash
# 既存の命名パターンを確認
grep -n "const\|let\|var\|function\|class\|def\|type\|interface" <主要ファイル> | head -30
```

ESLint / Pylint / RuboCop などの設定ファイルも確認する：

```bash
cat .eslintrc* 2>/dev/null || cat eslint.config* 2>/dev/null
cat .pylintrc 2>/dev/null || cat pyproject.toml 2>/dev/null | grep -A10 '\[tool.ruff\]'
```

### 3. 命名の観点でチェック

#### 観点 1: ケース規則の違反

各要素が対応するケース規則に従っているか確認する。

#### 観点 2: 意味不明・省略過多な名前

- 1文字変数（ループ変数 `i`/`j` を除く）が使われていないか
- `data`・`info`・`temp`・`flag` など意味が曖昧な名前はないか
- 過度な省略（`usrCnt`→`userCount`、`mgr`→`manager`）はないか

#### 観点 3: 誤解を招く名前

- boolean 型なのに `is_`/`has_`/`can_` プレフィックスがないか
- 関数名が動詞で始まっていないか（`user()` → `getUser()`）
- 配列・リストなのに単数形を使っていないか（`user` → `users`）

#### 観点 4: 一貫性の欠如

- 同じ概念に複数の名前が使われていないか（`user`/`member`/`account` など混在）
- 取得系関数が `get`/`fetch`/`load`/`find` で混在していないか

#### 観点 5: スコープと長さのバランス

- グローバルスコープの変数に短すぎる名前はないか
- 逆にローカルの一時変数に長すぎる名前はないか

### 4. 結果の出力フォーマット

```
## 命名規則レビュー結果

### ❌ 規則違反
- [ファイル:行番号] `変数名`
  - 問題: camelCase であるべきところ snake_case が使われている
  - 提案: `correct_name` → `correctName`

### ⚠️ 改善推奨
- [ファイル:行番号] `変数名`
  - 問題: 意図が伝わりにくい
  - 提案: `d` → `durationMs`

### ✅ 問題なし
- 命名規則の違反は見つかりませんでした
```
