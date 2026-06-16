---
name: e2e-scenario
description: |
  ユーザーストーリーからE2Eテストシナリオを作成する。
  ユーザーが「E2Eテスト書いて」「シナリオテスト作って」「受け入れテストを作成して」
  などと言った時に使用する。
---

# E2Eテストシナリオ生成

ユーザーストーリー・仕様・既存コードを解析し、E2Eテストシナリオ（Given-When-Then 形式）とテストコードを生成します。

## 使い方

- 「E2Eテスト書いて」→ 現在の機能に対してシナリオを生成
- 「ログイン機能のE2Eテスト作って」→ 指定機能のシナリオを生成
- 「この仕様書からE2Eシナリオ作って」→ 仕様書を基にシナリオを生成

## 手順

### 1. 対象機能の把握

ユーザーストーリーまたは対象コードを読み込む：

```bash
# ルーティング・エンドポイントを確認
cat routes/* 2>/dev/null || cat app/routes* 2>/dev/null
grep -rn "router\.\|app\.\(get\|post\|put\|delete\)" src/ --include="*.ts" | head -20
```

以下を整理する：
- 主なユーザーアクション（操作の流れ）
- 成功パス（Happy Path）
- 失敗パス（エラー・権限なし・入力誤り）

### 2. E2Eフレームワークの特定

```bash
cat package.json 2>/dev/null | grep -E '"playwright|"cypress|"puppeteer'
ls cypress/ 2>/dev/null && echo "Cypress detected"
ls playwright.config* 2>/dev/null && echo "Playwright detected"
```

フレームワークが未導入の場合は Playwright を推奨する。

### 3. シナリオ設計

ユーザーストーリーを以下の形式に変換する：

```gherkin
Feature: <機能名>

  Background:
    Given <前提条件>

  Scenario: <シナリオ名（正常系）>
    Given <初期状態>
    When  <操作>
    Then  <期待結果>

  Scenario: <シナリオ名（異常系）>
    Given <初期状態>
    When  <無効な操作>
    Then  <エラー表示>
```

設計すべきシナリオ：

| 種別 | 内容 |
|------|------|
| 正常系 | 典型的なユーザーフロー |
| 境界値 | 最大・最小の入力値 |
| 権限エラー | 未認証・権限なし |
| バリデーション | 不正入力・必須項目未入力 |
| 状態遷移 | 途中離脱・戻るボタン |

### 4. テストコードの生成

#### Playwright（TypeScript）の例

```typescript
import { test, expect } from '@playwright/test';

test.describe('<機能名>', () => {
  test.beforeEach(async ({ page }) => {
    // セットアップ
  });

  test('<シナリオ名>', async ({ page }) => {
    // Arrange
    await page.goto('/path');

    // Act
    await page.getByRole('button', { name: '送信' }).click();

    // Assert
    await expect(page.getByText('成功しました')).toBeVisible();
  });
});
```

#### Cypress の例

```typescript
describe('<機能名>', () => {
  beforeEach(() => {
    cy.visit('/path');
  });

  it('<シナリオ名>', () => {
    cy.get('[data-testid="submit"]').click();
    cy.contains('成功しました').should('be.visible');
  });
});
```

### 5. テストデータ・セットアップの提示

- テスト用ユーザー・データのセットアップ方法
- テスト後のクリーンアップ方法
- CI での実行コマンド
