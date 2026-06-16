---
name: api-doc
description: |
  APIエンドポイントからOpenAPI（Swagger）仕様書のドラフトを生成する。
  ユーザーが「API仕様書作って」「OpenAPIを生成して」「Swaggerドキュメント書いて」
  などと言った時に使用する。
---

# OpenAPI仕様書生成

ルーティング定義・コントローラー・型定義を解析し、OpenAPI 3.0 形式のAPI仕様書ドラフトを生成します。

## 使い方

- 「API仕様書作って」→ プロジェクト全体のAPIを仕様書化
- 「このエンドポイントをOpenAPIに書いて」→ 指定エンドポイントを仕様書化
- 「Swagger更新して」→ 既存仕様書に追加エンドポイントを反映

## 手順

### 1. エンドポイントの収集

```bash
# Express / Fastify (TypeScript)
grep -rn "router\.\|app\.\(get\|post\|put\|patch\|delete\)" src/ --include="*.ts" | grep -v test | head -30

# Rails
cat config/routes.rb

# FastAPI (Python)
grep -rn "@app\.\|@router\." . --include="*.py" | head -30

# Go (gin / chi)
grep -rn "\.GET\|\.POST\|\.PUT\|\.DELETE\|\.PATCH" . --include="*.go" | head -30
```

### 2. 各エンドポイントの詳細確認

各エンドポイントについて以下を把握する：
- HTTPメソッド・パス
- リクエスト（パスパラメータ・クエリパラメータ・ボディ）
- レスポンス（正常系・エラー系のステータスコードと型）
- 認証の要否

### 3. 型定義の確認

```bash
# TypeScript
cat src/types/*.ts 2>/dev/null || cat src/models/*.ts 2>/dev/null

# Python (Pydantic)
cat app/schemas/*.py 2>/dev/null

# Go
cat internal/models/*.go 2>/dev/null
```

### 4. OpenAPI 3.0 仕様書の生成

```yaml
openapi: 3.0.3
info:
  title: <API名>
  version: 1.0.0
  description: <APIの概要>

servers:
  - url: https://api.example.com/v1
    description: 本番環境
  - url: http://localhost:3000/v1
    description: 開発環境

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  schemas:
    User:
      type: object
      required: [id, name, email]
      properties:
        id:
          type: string
          format: uuid
          example: "550e8400-e29b-41d4-a716-446655440000"
        name:
          type: string
          example: "山田太郎"
        email:
          type: string
          format: email
          example: "yamada@example.com"

    ErrorResponse:
      type: object
      required: [code, message]
      properties:
        code:
          type: string
        message:
          type: string

paths:
  /users/{id}:
    get:
      summary: ユーザー取得
      description: 指定IDのユーザー情報を取得する
      security:
        - bearerAuth: []
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: 成功
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '404':
          description: ユーザーが存在しない
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: 認証エラー
```

### 5. 出力と検証

生成した仕様書を YAML または JSON で出力する。

```bash
# Swagger Editor で検証（ローカル）
docker run -p 8080:8080 swaggerapi/swagger-editor
```

既存の `openapi.yaml` / `swagger.yaml` がある場合は差分を提示し、マージ方針を確認する。
