---
name: write-test
description: |
  指定したコードや関数に対してテストを生成・追加する。
  ユーザーが「テスト書いて」「テストを追加して」「テストコードを作って」
  などと言った時に使用する。
---

# 🧪 テストコード生成

対象コードを解析し、正常系・異常系・境界値を網羅したテストコードを生成します。

## 使い方

- 「テスト書いて」→ 現在のファイル/選択コードにテスト生成
- 「`src/auth.ts` のテスト書いて」→ 指定ファイルのテスト生成
- 「カバレッジ上げて」→ 既存テストの不足ケースを追加

## 手順

### 1. 対象コードの確認

テスト対象ファイルを読み込み、以下を把握する：

- 公開されている関数・クラス・メソッド
- 引数の型と戻り値
- 副作用（I/O、DB、外部API呼び出しなど）
- エラーが発生しうる条件

### 2. テストフレームワークの特定

既存テストファイルを検索してフレームワークを確認する：

```bash
# テストファイルを探す
find . -name "*.test.*" -o -name "*.spec.*" -o -name "*_test.*" | head -20

# package.json / pyproject.toml などで確認
cat package.json 2>/dev/null | grep -E '"jest|"vitest|"mocha'
cat pyproject.toml 2>/dev/null | grep -E 'pytest|unittest'
```

フレームワークが不明な場合は言語に応じたデファクトを使用する：
- TypeScript/JavaScript → Jest / Vitest
- Python → pytest
- Ruby → RSpec
- Go → `testing` パッケージ

### 3. 既存テストのスタイル確認

既存テストがある場合はそのスタイルに合わせる：

```bash
# 既存のテストファイルを確認
cat <existing_test_file>
```

### 4. テストケースの設計

以下のカテゴリを網羅するケースを設計する：

| カテゴリ | 内容 |
|----------|------|
| **正常系** | 期待される入力 → 期待される出力 |
| **異常系** | 無効な入力・エラー条件 → 例外/エラーレスポンス |
| **境界値** | 最小値・最大値・空・null・undefined |
| **副作用** | 外部依存のモックと呼び出し検証 |

### 5. テストコードの生成

以下のスタイルで記述する：

- **テスト名**: 「〜のとき、〜すること」形式で日本語（例: `it('引数が空のとき、エラーをスローすること')`）
- **構造**: AAA パターン（Arrange / Act / Assert）
- **モック**: 最小限にとどめ、振る舞いをテストする（実装詳細に依存しない）
- **独立性**: 各テストは他のテストの状態に依存しない

```typescript
// 例: Jest / TypeScript
describe('関数名', () => {
  describe('正常系', () => {
    it('有効な引数のとき、期待する値を返すこと', () => {
      // Arrange
      const input = ...;
      // Act
      const result = targetFunction(input);
      // Assert
      expect(result).toBe(expected);
    });
  });

  describe('異常系', () => {
    it('引数が null のとき、エラーをスローすること', () => {
      expect(() => targetFunction(null)).toThrow(TypeError);
    });
  });
});
```

### 6. テストファイルの配置

既存の規約に従ってファイルを配置する：

- 同階層に `<filename>.test.ts` を作成（例: `src/auth.ts` → `src/auth.test.ts`）
- または `__tests__/` ディレクトリに配置

### 7. テスト実行の確認

生成後、テストが通ることを確認するコマンドを提示する：

```bash
# 例
npm test -- <filename>
pytest <testfile> -v
go test ./...
```
