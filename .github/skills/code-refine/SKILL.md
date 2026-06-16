---
name: code-refine
description: |
  コードの臭いを検出して構造改善の具体案を示す。
  ユーザーが「リファクタリングして」「コードを整理して」「重複を排除して」
  などと言った時に使用する。
---

# リファクタリング提案

対象コードを解析し、可読性・保守性・再利用性を向上させるリファクタリング案を提示します。コードの動作を変えずに構造を改善します。

## 使い方

- 「リファクタリングして」→ 現在のファイル/差分をリファクタリング
- 「この関数を整理して」→ 指定関数をリファクタリング
- 「重複コードを排除して」→ DRY原則に基づいて整理

## 手順

### 1. 対象コードの確認

```bash
cat <target_file>
```

コードの規模・複雑度・依存関係を把握する。

### 2. リファクタリングが必要な箇所の特定

以下の「コードの臭い（Code Smells）」を検出する：

#### 臭い 1: 重複コード (DRY違反)

- 同じロジックが複数箇所に存在する
- コピーペーストで作られた関数群

```typescript
// NG: 重複
function validateEmail(email: string) { /* ... */ }
function validateAdminEmail(email: string) { /* ... */ }  // ほぼ同じ

// OK: 共通化
function validateEmail(email: string, options?: { domain?: string }) { /* ... */ }
```

#### 臭い 2: 長すぎる関数

- 1関数が50行以上になっている
- 複数の抽象レベルが混在している

分割の基準：
- 「何をするか（What）」と「どうするか（How）」を分離する
- コメントが必要な処理ブロックは関数に切り出す

#### 臭い 3: 長すぎる引数リスト

```typescript
// NG: 引数が多い
function createUser(name, email, age, role, department, isActive) {}

// OK: オブジェクトにまとめる
function createUser(params: CreateUserParams) {}
```

#### 臭い 4: 単一責任原則（SRP）違反

- 1クラス・1関数が複数の責務を持っている
- 「〜かつ〜する」と説明が必要な関数

#### 臭い 5: 深いネスト

- if/else・try/catch が3段以上ネストしている
- 早期リターン（Guard Clause）で改善できないか確認

```typescript
// NG: 深いネスト
function process(user) {
  if (user) {
    if (user.isActive) {
      if (user.hasPermission) {
        // 処理
      }
    }
  }
}

// OK: 早期リターン
function process(user) {
  if (!user) return;
  if (!user.isActive) return;
  if (!user.hasPermission) return;
  // 処理
}
```

#### 臭い 6: マジックナンバー・マジック文字列

```typescript
// NG
if (status === 3) { /* ... */ }

// OK
const STATUS_CANCELLED = 3;
if (status === STATUS_CANCELLED) { /* ... */ }
```

### 3. リファクタリング計画の作成

検出した問題を以下の観点で優先順位付けする：

| 優先度 | 基準 |
|--------|------|
| High | 変更頻度が高い・バグ発生リスクが高い箇所 |
| Medium | 可読性を大きく損なっている箇所 |
| Low | 軽微な改善（名前変更・コメント追加等） |

### 4. リファクタリングコードの提示

- 変更前と変更後を対比して提示する
- テストが存在する場合は、テストが通ることを確認する手順も示す
- 破壊的変更がある場合（公開APIの変更）は必ず明示する
