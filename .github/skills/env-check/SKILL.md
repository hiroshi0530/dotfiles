---
name: env-check
description: |
  環境変数の設定漏れ・本番/開発環境の差分を検出する。
  ユーザーが「環境変数を確認して」「.env の設定漏れを検出して」「環境差分を調べて」
  などと言った時に使用する。
---

# 環境変数チェック

`.env` ファイル・コード・インフラ設定を解析し、環境変数の設定漏れ・環境間の差分・セキュリティリスクを検出します。

## 使い方

- 「環境変数を確認して」→ 設定漏れ・問題点を検出
- 「.env の設定漏れを検出して」→ `.env.example` との差分を確認
- 「環境差分を調べて」→ 開発/ステージング/本番の設定差分を確認

## 手順

### 1. 環境変数ファイルの確認

```bash
# .env 系ファイルを列挙
ls -la .env* 2>/dev/null

# .env.example（テンプレート）を確認
cat .env.example 2>/dev/null || cat .env.sample 2>/dev/null

# .gitignore に .env が含まれているか確認（セキュリティチェック）
grep -n "^\.env" .gitignore 2>/dev/null
```

### 2. コード内で使用されている環境変数を収集

```bash
# Node.js / TypeScript
grep -rn "process\.env\." src/ --include="*.ts" --include="*.js" | \
  grep -oP 'process\.env\.\K\w+' | sort -u

# Python
grep -rn "os\.environ\|os\.getenv" . --include="*.py" | \
  grep -oP '(?:os\.environ\[|os\.getenv\()["\x27]\K[^"'\'']+' | sort -u

# Ruby
grep -rn 'ENV\[' . --include="*.rb" | \
  grep -oP 'ENV\["?\K[^"\]]+' | sort -u
```

### 3. 設定漏れの検出

`.env.example` に定義された変数と実際の `.env` を比較する：

```bash
# キーの差分を確認（値は表示しない）
diff <(grep -v '^#' .env.example | grep '=' | cut -d= -f1 | sort) \
     <(grep -v '^#' .env | grep '=' | cut -d= -f1 | sort)
```

コード内で使用されているが `.env` / `.env.example` に定義されていない変数を抽出する。

### 4. セキュリティリスクの検出

#### リスク 1: .env がGitにコミットされている

```bash
# .env がトラッキングされていないか確認
git ls-files .env 2>/dev/null && echo "⚠️ .env がGitに追加されています！"

# 過去のコミットに .env が含まれていないか確認
git --no-pager log --all --full-history -- .env | head -5
```

#### リスク 2: ハードコードされたシークレット

```bash
# APIキー・トークンのパターンを検索
grep -rn \
  -e "api_key\s*=\s*['\"][A-Za-z0-9]" \
  -e "secret\s*=\s*['\"][A-Za-z0-9]" \
  -e "password\s*=\s*['\"][^$]" \
  src/ --include="*.ts" --include="*.py" --include="*.rb" \
  | grep -v ".env\|test\|spec\|mock" | head -20
```

#### リスク 3: デフォルト値のまま使用

```bash
# デフォルト値が明らかに危険なものを確認
grep -rn "process\.env\.\w\+ || ['\"]secret\|process\.env\.\w\+ || ['\"]password\|process\.env\.\w\+ || ['\"]admin" \
  src/ 2>/dev/null
```

### 5. 環境間の差分確認

```bash
# 開発と本番の設定キーを比較（値は含まない）
diff <(grep -v '^#' .env.development | grep '=' | cut -d= -f1 | sort) \
     <(grep -v '^#' .env.production | grep '=' | cut -d= -f1 | sort)
```

### 6. 結果の出力フォーマット

```
## 環境変数チェック結果

### 🔴 Critical
- `.env` が `.gitignore` に含まれていません → 即座に追加してください
- `DATABASE_URL` が本番環境に設定されていません

### 🟡 Warning
- `.env.example` に `NEW_API_KEY` が定義されていますが `.env` に設定がありません
- 開発環境のみに `DEBUG_FLAG=true` が設定されています

### 🟢 OK
- セキュリティ上の問題は検出されませんでした
- 開発・本番環境で必須の環境変数が揃っています
```

### 7. `.env.example` の更新

新しい環境変数がある場合は `.env.example` への追記案を提示する（実際の値は含めない）：

```bash
# 追記例
NEW_FEATURE_API_KEY=your_api_key_here
NEW_FEATURE_ENDPOINT=https://api.example.com
```
