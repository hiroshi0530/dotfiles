---
name: doc-gen
description: |
  関数・クラス・モジュールにJSDoc / TSDoc / docstring などのドキュメントコメントを自動生成する。
  ユーザーが「ドキュメント書いて」「JSDoc追加して」「docstring生成して」
  などと言った時に使用する。
---

# ドキュメントコメント生成

対象コードを解析し、言語・フレームワークに適したドキュメントコメント（JSDoc / TSDoc / docstring / GoDoc 等）を生成します。

## 使い方

- 「ドキュメント書いて」→ 現在のファイルにコメントを追加
- 「JSDoc追加して」→ TypeScript/JavaScript ファイルに JSDoc を生成
- 「この関数にdocstring書いて」→ 指定関数にコメントを追加

## 手順

### 1. 対象コードの確認

対象ファイルを読み込む：

```bash
cat <target_file>
```

以下を把握する：
- 言語・フレームワーク
- 公開されている関数・クラス・メソッド
- 引数の型・戻り値の型
- スローされる例外・エラー
- 副作用（DB更新・ファイルI/O・外部API呼び出しなど）

### 2. コメント形式の決定

言語に応じたフォーマットを使用する：

| 言語 | 形式 |
|------|------|
| TypeScript / JavaScript | TSDoc / JSDoc |
| Python | Google スタイル docstring |
| Go | GoDoc コメント |
| Ruby | YARD |
| Java / Kotlin | JavaDoc |

既存ファイルにコメントがある場合はそのスタイルに統一する。

### 3. ドキュメントコメントの生成

#### TypeScript / JSDoc の例

```typescript
/**
 * ユーザーをIDで取得する。
 *
 * @param userId - 取得対象のユーザーID
 * @param options - 取得オプション
 * @param options.includeDeleted - 論理削除済みのユーザーを含める場合は `true`
 * @returns 見つかった場合はユーザーオブジェクト、見つからない場合は `null`
 * @throws {DatabaseError} DB接続に失敗した場合
 *
 * @example
 * const user = await getUserById('123');
 * if (user) {
 *   console.log(user.name);
 * }
 */
async function getUserById(userId: string, options?: { includeDeleted?: boolean }): Promise<User | null>
```

#### Python docstring の例

```python
def calculate_discount(price: float, rate: float) -> float:
    """割引後の価格を計算する。

    Args:
        price: 元の価格（0以上）
        rate: 割引率（0.0〜1.0）

    Returns:
        割引後の価格

    Raises:
        ValueError: price が負の値、または rate が 0〜1 の範囲外の場合

    Example:
        >>> calculate_discount(1000, 0.1)
        900.0
    """
```

#### Go の例

```go
// GetUserByID はIDでユーザーを取得する。
// ユーザーが存在しない場合は nil と nil を返す。
// DB接続に失敗した場合はエラーを返す。
func GetUserByID(ctx context.Context, id string) (*User, error) {
```

### 4. 生成ルール

- **簡潔かつ正確に**: 実装を見ればわかることは書かない
- **"なぜ"を補足**: コードから読み取れない意図・制約を説明する
- **@example**: 複雑な関数には使用例を添える
- **@deprecated**: 非推奨の場合は代替を明示する
- **型情報**: TypeScript では型注釈と重複しないよう調整する

### 5. 既存コードへの適用

コメントを追加したコードを提示し、元のコードと置き換えるか確認する。
