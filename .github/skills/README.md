# GitHub Copilot Skills 一覧

`.github/skills/` に配置された再利用可能なワークフロー集です。
`/skill-name` で直接呼び出すか、自然言語で話しかけると自動的に読み込まれます。

## ドキュメント

| skill | 呼び出し例 | 概要 |
|-------|-----------|------|
| [docstring-add](./docstring-add/SKILL.md) | 「JSDoc追加して」 | 関数・クラスの引数・戻り値・例外をコメントとして出力する |
| [readme-sync](./readme-sync/SKILL.md) | 「READMEを更新して」 | コードの変更に追随して README の該当セクションを書き直す |
| [changelog](./changelog/SKILL.md) | 「CHANGELOG更新して」 | マージされた変更をもとに CHANGELOG を追記・整形する |
| [release-note](./release-note/SKILL.md) | 「リリースノートを作って」 | タグ間の差分からリリースの変更内容を整理して記述する |

## ブランチ・Git

| skill | 呼び出し例 | 概要 |
|-------|-----------|------|
| [branch](./branch/SKILL.md) | 「ブランチ切って」 | type/description 形式でブランチを命名して切り替える |
| [branch-cleanup](./branch-cleanup/SKILL.md) | 「マージ済みブランチを削除して」 | 統合済みの不要ブランチを一括で整理する |
| [commit](./commit/SKILL.md) | 「コミットして」 | 変更内容を解析して type・scope・subject を自動生成しコミットする |
| [commit-push](./commit-push/SKILL.md) | 「コミットしてプッシュして」 | コミットメッセージ生成からリモートへの反映まで一括で実行する |

## GitHub 連携

| skill | 呼び出し例 | 概要 |
|-------|-----------|------|
| [pull-request](./pull-request/SKILL.md) | 「PR を作って」 | 差分を解析してタイトル・本文・チェックリストを含む PR を作成する |
| [issue](./issue/SKILL.md) | 「Issue 作って」 | バグ報告・機能要望・タスクを適切な形式で起票する |
| [issue-split](./issue-split/SKILL.md) | 「タスクを分解して」 | 要件を独立した作業単位に分割して Issue 形式で整理する |

## レビュー

| skill | 呼び出し例 | 概要 |
|-------|-----------|------|
| [review-diff](./review-diff/SKILL.md) | 「レビューして」 | 品質・安全性・速度の3軸でコードを評価する |
| [owasp-audit](./owasp-audit/SKILL.md) | 「セキュリティチェックして」 | セキュリティ上の欠陥をOWASP基準で診断する |
| [perf-audit](./perf-audit/SKILL.md) | 「パフォーマンス確認して」 | クエリの無駄・計算量・処理ボトルネックを検出する |

## テスト

| skill | 呼び出し例 | 概要 |
|-------|-----------|------|
| [write-test](./write-test/SKILL.md) | 「テスト書いて」 | Happy Path から例外・境界値まで網羅したテストコードを出力する |
| [flow-test](./flow-test/SKILL.md) | 「E2Eテスト書いて」 | 操作フローを Given-When-Then 形式のシナリオに変換する |
| [boundary-scan](./boundary-scan/SKILL.md) | 「エッジケースを探して」 | 見落とされがちな入力・状態・タイミングのパターンを洗い出す |

## リファクタリング系

| skill | 呼び出し例 | 概要 |
|-------|-----------|------|
| [code-refine](./code-refine/SKILL.md) | 「リファクタリングして」 | コードの臭いを検出して構造改善の具体案を示す |

## デプロイ・運用系

| skill | 呼び出し例 | 概要 |
|-------|-----------|------|
| [release-gate](./release-gate/SKILL.md) | 「デプロイ前チェックして」 | リリース前に漏れなく確認すべき項目を段階的に提示する |
| [revert-plan](./revert-plan/SKILL.md) | 「ロールバック手順を作って」 | インシデント発生時に迅速に切り戻せる手順書を作成する |
| [dotenv-audit](./dotenv-audit/SKILL.md) | 「環境変数を確認して」 | .env の欠落・環境間のずれ・平文シークレットの混入を検出する |
