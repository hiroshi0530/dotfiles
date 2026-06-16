---
name: rollback-guide
description: |
  障害発生時のロールバック手順を生成する。
  ユーザーが「ロールバック手順を作って」「障害時の対応手順を書いて」「元に戻す手順を教えて」
  などと言った時に使用する。
---

# ロールバック手順生成

直近のデプロイ内容・変更種別を解析し、障害発生時に迅速に対応できるロールバック手順書を生成します。

## 使い方

- 「ロールバック手順を作って」→ 直近のデプロイに対するロールバック手順を生成
- 「障害時の対応手順を書いて」→ インシデント対応フロー込みで生成
- 「元に戻す手順を教えて」→ 指定のデプロイのロールバック手順を生成

## 手順

### 1. デプロイ内容の確認

```bash
# 直近のデプロイコミットを確認
git --no-pager log --oneline -10

# 変更ファイルの確認
git --no-pager diff HEAD~1 --stat

# DBマイグレーションの有無を確認
ls db/migrate/ 2>/dev/null | tail -5
ls migrations/ 2>/dev/null | tail -5
```

変更の種別を分類する：
- アプリケーションコードのみ
- DBマイグレーションあり
- 環境変数・設定変更あり
- インフラ変更あり

### 2. ロールバック手順の生成

#### パターン A: コードのみのロールバック

```bash
# 直前のタグ/コミットを確認
git --no-pager tag --sort=-version:refname | head -5
git --no-pager log --oneline -5

# デプロイツールによるロールバック
# Heroku
heroku rollback --app <app-name>

# AWS ECS (前のタスク定義に戻す)
aws ecs update-service --cluster <cluster> --service <service> \
  --task-definition <previous-task-def>

# Kubernetes
kubectl rollout undo deployment/<deployment-name>
kubectl rollout status deployment/<deployment-name>

# Vercel
vercel rollback <deployment-url>

# 手動（git reset）
git revert HEAD --no-edit
git push origin main
```

#### パターン B: DBマイグレーションありのロールバック

⚠️ **データが失われる可能性があるため、必ずバックアップを確認してから実施する**

```bash
# マイグレーションのロールバック
# Rails
rails db:rollback STEP=1

# Node.js (Knex)
npx knex migrate:rollback

# Python (Alembic)
alembic downgrade -1

# Flyway
flyway -url=<url> -user=<user> -password=<pass> undo
```

ロールバック後にDBの整合性を確認する：
```sql
-- 対象テーブルのレコード数・構造を確認
SELECT COUNT(*) FROM <affected_table>;
\d <affected_table>  -- PostgreSQL
DESCRIBE <affected_table>;  -- MySQL
```

#### パターン C: 設定・環境変数のロールバック

```bash
# 環境変数を元の値に戻す（各プラットフォームに応じて）
heroku config:set KEY=old_value --app <app-name>
# または管理コンソールから手動で変更
```

### 3. ロールバック判断基準

以下の指標を監視し、閾値を超えた場合にロールバックを判断する：

| 指標 | 正常範囲 | ロールバック判断閾値 |
|------|---------|---------------------|
| エラー率 | < 1% | > 5% かつ 5分継続 |
| P99レイテンシ | < 2s | > 10s |
| CPU使用率 | < 70% | > 90% かつ 5分継続 |
| 500エラー数 | < 10/min | > 100/min |

### 4. ロールバック後の確認

```bash
# サービスの正常性確認
curl -f https://<your-service>/health

# ログの確認
# Heroku
heroku logs --tail --app <app-name>

# Kubernetes
kubectl logs -l app=<app-name> --tail=100
```

確認項目：
- [ ] エラー率が正常範囲に戻った
- [ ] 主要な機能（ログイン・決済等）が正常に動作する
- [ ] DBの整合性に問題がない

### 5. インシデントレポートのテンプレート

```markdown
## インシデントレポート

- **発生時刻**: YYYY-MM-DD HH:MM JST
- **検知方法**: アラート / ユーザー報告
- **影響範囲**: サービス名・機能名・影響ユーザー数
- **原因**: デプロイ内容（コミットID: xxxx）
- **対応**: ロールバック実施（HH:MM JST）
- **復旧時刻**: HH:MM JST
- **再発防止策**: ...
```
