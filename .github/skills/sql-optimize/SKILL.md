---
name: sql-optimize
description: |
  スロークエリの改善提案・インデックス設計レビューを行う。
  ユーザーが「クエリを最適化して」「インデックスを見て」「スロークエリを改善して」
  などと言った時に使用する。
---

# SQLクエリ最適化

SQLクエリ・ORM定義を解析し、スロークエリの改善提案・インデックス設計レビュー・実行計画の読み方を提示します。

## 使い方

- 「クエリを最適化して」→ 対象クエリの改善提案
- 「インデックスを見て」→ インデックス設計のレビュー
- 「スロークエリを改善して」→ 実行計画に基づいた最適化

## 手順

### 1. 対象クエリの確認

対象のSQLまたはORMコードを読み込む：

```bash
cat <target_file>
```

使用しているDBを確認する（PostgreSQL / MySQL / SQLite / etc.）。

### 2. スロークエリの原因を分析

#### 原因 1: フルテーブルスキャン（インデックスの欠如）

```sql
-- NG: name に インデックスなし → フルスキャン
SELECT * FROM users WHERE name = '山田太郎';

-- 対策: インデックスを追加
CREATE INDEX idx_users_name ON users(name);
```

WHERE句・JOIN条件・ORDER BY対象のカラムにインデックスがあるか確認する。

#### 原因 2: 非効率なJOIN

- 結合するテーブルのJOINキーにインデックスがあるか
- 結合後に絞り込む（WHERE）ではなく、結合前に絞り込めるか
- 不要なJOINがないか（サブクエリや EXISTS で代替できるか）

```sql
-- NG: 全ユーザーを結合してからフィルタ
SELECT u.* FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status = 'completed';

-- OK: 絞り込んでから結合（サブクエリ）
SELECT u.* FROM users u
WHERE u.id IN (
  SELECT user_id FROM orders WHERE status = 'completed'
);
```

#### 原因 3: `SELECT *` の使用

```sql
-- NG: 不要なカラムも取得
SELECT * FROM users;

-- OK: 必要なカラムのみ
SELECT id, name, email FROM users;
```

#### 原因 4: N+1 クエリ

```sql
-- N+1 の例（ORMのループ内クエリ）
-- 1回目: SELECT * FROM users
-- N回目: SELECT * FROM posts WHERE user_id = ?

-- 対策: JOIN または IN句で一括取得
SELECT u.*, p.title FROM users u
LEFT JOIN posts p ON u.id = p.user_id;
```

#### 原因 5: インデックスが効かないケース

```sql
-- NG: 関数・型変換でインデックス無効化
WHERE LOWER(email) = 'test@example.com'
WHERE CAST(created_at AS DATE) = '2024-01-01'
WHERE id + 1 = 100

-- OK: インデックスが使われる
WHERE email = 'test@example.com'  -- 関数インデックスか正規化
WHERE created_at >= '2024-01-01' AND created_at < '2024-01-02'
WHERE id = 99
```

#### 原因 6: 複合インデックスの列順

```sql
-- 複合インデックス: (status, created_at)
-- OK: 左端の列を含むクエリ
WHERE status = 'active' AND created_at > '2024-01-01'

-- NG: 左端の列を含まない（インデックス使用不可）
WHERE created_at > '2024-01-01'
```

### 3. 実行計画の確認方法

```sql
-- PostgreSQL
EXPLAIN ANALYZE SELECT ...;

-- MySQL
EXPLAIN SELECT ...;
```

実行計画で注意するポイント：
- `Seq Scan` / `ALL` → フルテーブルスキャン（要インデックス）
- `rows` の推定値と実際値の乖離 → 統計情報の更新が必要
- `cost` の高いノード → 最適化の優先対象

### 4. インデックス設計のレビュー

```bash
# 既存のインデックス一覧（PostgreSQL）
\d <table_name>

# MySQL
SHOW INDEX FROM <table_name>;
```

以下を確認する：
- 重複インデックスがないか
- 使われていないインデックスがないか（書き込みのオーバーヘッドになる）
- カーディナリティが低いカラム（boolean等）にインデックスがないか

### 5. 改善SQLの提示

改善前・改善後のSQL、および追加推奨インデックスを提示する。
