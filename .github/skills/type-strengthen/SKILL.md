---
name: type-strengthen
description: |
  TypeScriptのany型を排除し、型ガードや厳密な型定義を追加する。
  ユーザーが「型を強化して」「anyを排除して」「型ガードを追加して」
  などと言った時に使用する。
---

# TypeScript型強化

`any` 型の排除・型ガードの追加・型定義の精緻化を行い、TypeScriptの型安全性を向上させます。

## 使い方

- 「型を強化して」→ 現在のファイルの型安全性を向上
- 「anyを排除して」→ `any` 型を適切な型に置き換え
- 「型ガードを追加して」→ union型・不明な型に型ガードを追加

## 手順

### 1. 対象ファイルの確認

```bash
cat <target_file>
```

TypeScript設定も確認する：

```bash
cat tsconfig.json
```

`strict: true` になっているか確認し、なければ有効化を提案する。

### 2. 型の問題箇所を特定

#### 問題 1: `any` 型の使用

```bash
# any の検出
grep -n ": any\|as any\|<any>" <target_file>
```

`any` の代替として検討する型：

| 状況 | 代替 |
|------|------|
| 何でも受け取るが使わない | `unknown` |
| 複数の型が入りうる | Union型 `string \| number` |
| オブジェクトだが構造不明 | `Record<string, unknown>` |
| 外部APIのレスポンス | Zod等でスキーマ定義 |
| コールバック引数 | ジェネリクス `<T>` |

#### 問題 2: `as` による型アサーション

```typescript
// NG: 強制キャスト
const user = data as User;

// OK: 型ガード
function isUser(data: unknown): data is User {
  return (
    typeof data === 'object' &&
    data !== null &&
    'id' in data &&
    'name' in data
  );
}
if (isUser(data)) { /* data は User 型 */ }
```

#### 問題 3: オプショナルチェーンの不足

```typescript
// NG: 非null アサーション
const name = user!.profile!.name;

// OK: optional chaining + nullish coalescing
const name = user?.profile?.name ?? 'Unknown';
```

#### 問題 4: 過度に広い型

```typescript
// NG: 広すぎる
type Status = string;

// OK: リテラル型のユニオン
type Status = 'active' | 'inactive' | 'pending';
```

#### 問題 5: 型定義の不足

- 関数の引数・戻り値に型注釈がない
- オブジェクトリテラルに型がない

### 3. 型ガードのパターン

#### プリミティブ型ガード

```typescript
function isString(value: unknown): value is string {
  return typeof value === 'string';
}
```

#### オブジェクト型ガード

```typescript
function isApiError(error: unknown): error is ApiError {
  return (
    typeof error === 'object' &&
    error !== null &&
    'statusCode' in error &&
    'message' in error
  );
}
```

#### Zodを使った実行時バリデーション

```typescript
import { z } from 'zod';

const UserSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(1),
  email: z.string().email(),
});

type User = z.infer<typeof UserSchema>;

// 実行時に安全に型を付与
const user = UserSchema.parse(unknownData);
```

### 4. 修正コードの提示

- 変更前・変更後を対比して提示する
- `tsc --noEmit` でコンパイルエラーがないことを確認する手順を示す

```bash
npx tsc --noEmit
```
