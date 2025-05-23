# SmartFridgeAssistant

スマート冷蔵庫アシスタントの音声合成機能を実装するためのPythonスクリプトです。

## 目的

このプロジェクトは、以下の課題を解決するために開発されました：

1. **家族のコミュニケーション向上**
   - 忙しい家族間での情報共有の効率化
   - 冷蔵庫を開けた際に、重要な情報を音声で通知
   - 視覚的な情報に頼らない情報伝達

2. **学校関連情報の効率的な管理**
   - 学校行事の自動通知
   - 給食献立の事前案内
   - 家族全員への情報共有の自動化

3. **食材管理の最適化**
   - 賞味期限の音声通知
   - 在庫状況の音声案内
   - 買い物リストの自動生成

4. **アクセシビリティの向上**
   - 視覚障害のある家族への情報提供
   - 高齢者への分かりやすい情報伝達
   - 多言語対応による国際的な家族への対応

## 背景

このプロジェクトは、以下のような社会背景から生まれました：

1. **核家族化の進行**
   - 家族の生活時間の不一致
   - 情報共有の機会減少
   - コミュニケーションの希薄化

2. **デジタル化の進展**
   - 学校からの情報提供のデジタル化
   - 家庭内IoT機器の普及
   - 音声インターフェースの一般化

3. **食生活の多様化**
   - 食材管理の複雑化
   - 食品ロスの問題
   - 健康管理の重要性

4. **高齢化社会への対応**
   - 高齢者の情報アクセス支援
   - 家族の見守り機能
   - 生活支援の自動化

## 機能

- テキストを自然な音声に変換
- 複数の日本語音声（男性/女性）から選択可能
- MP3形式で音声ファイルを出力
- 学校行事の音声案内
- 給食献立の音声案内
- 外部データの自動受信と同期

## データ受信機能

### 受信可能なデータ形式
- JSON形式の学校行事データ
- CSV形式の給食献立データ
- XML形式の通知データ

### データ受信方法
1. **APIエンドポイント**
   - 学校行事データ: `/api/v1/school_events`
   - 給食献立データ: `/api/v1/school_menus`
   - 認証: JWTトークン認証

2. **定期バッチ処理**
   - 毎日午前0時に前日のデータを削除
   - 毎日午前6時に新しいデータを受信
   - エラー発生時は3回までリトライ

3. **手動同期**
   - 管理画面から手動でデータ同期が可能
   - 特定の日付範囲を指定して同期可能

### データ検証
- 必須フィールドの存在確認
- 日付形式の検証
- データ型の検証
- 重複データのチェック

### エラーハンドリング
- 通信エラー時のリトライ処理
- 不正なデータのスキップ
- エラーログの記録
- 管理者への通知

## データベース設計

### テーブル構造

#### users（ユーザー）
| カラム名 | 型 | 説明 |
|----------|------|------------|
| id | integer | 主キー |
| name | string | ユーザー名 |
| email | string | メールアドレス |
| created_at | datetime | 作成日時 |
| updated_at | datetime | 更新日時 |

#### refrigerators（冷蔵庫）
| カラム名 | 型 | 説明 |
|----------|------|------------|
| id | integer | 主キー |
| user_id | integer | ユーザーID（外部キー） |
| name | string | 冷蔵庫の名前 |
| model | string | モデル名 |
| created_at | datetime | 作成日時 |
| updated_at | datetime | 更新日時 |

#### items（食材）
| カラム名 | 型 | 説明 |
|----------|------|------------|
| id | integer | 主キー |
| refrigerator_id | integer | 冷蔵庫ID（外部キー） |
| name | string | 食材名 |
| category | string | カテゴリー |
| quantity | integer | 数量 |
| unit | string | 単位 |
| expiry_date | date | 賞味期限 |
| created_at | datetime | 作成日時 |
| updated_at | datetime | 更新日時 |

#### school_events（学校行事）
| カラム名 | 型 | 説明 |
|----------|------|------------|
| id | integer | 主キー |
| user_id | integer | ユーザーID（外部キー） |
| title | string | 行事名 |
| description | text | 行事の説明 |
| event_date | date | 行事日 |
| start_time | time | 開始時間 |
| end_time | time | 終了時間 |
| location | string | 場所 |
| is_notified | boolean | 通知済みフラグ |
| created_at | datetime | 作成日時 |
| updated_at | datetime | 更新日時 |

#### school_menus（給食献立）
| カラム名 | 型 | 説明 |
|----------|------|------------|
| id | integer | 主キー |
| user_id | integer | ユーザーID（外部キー） |
| menu_date | date | 献立日 |
| main_dish | string | 主菜 |
| side_dish | string | 副菜 |
| soup | string | スープ |
| dessert | string | デザート |
| calories | integer | カロリー |
| is_notified | boolean | 通知済みフラグ |
| created_at | datetime | 作成日時 |
| updated_at | datetime | 更新日時 |

#### voice_settings（音声設定）
| カラム名 | 型 | 説明 |
|----------|------|------------|
| id | integer | 主キー |
| user_id | integer | ユーザーID（外部キー） |
| voice_type | string | 音声タイプ（男性/女性） |
| voice_name | string | 音声名 |
| volume | integer | 音量 |
| speed | integer | 速度 |
| created_at | datetime | 作成日時 |
| updated_at | datetime | 更新日時 |

### リレーションシップ

- users 1:N refrigerators
- refrigerators 1:N items
- users 1:N school_events
- users 1:N school_menus
- users 1:1 voice_settings

### インデックス

- users: email
- items: refrigerator_id, expiry_date
- school_events: user_id, event_date
- school_menus: user_id, menu_date
- voice_settings: user_id

## 必要条件

- Python 3.9以上
- edge-ttsライブラリ

## インストール方法

1. 必要なライブラリをインストール:
```bash
python3 -m pip install edge-tts
```

## 使用方法

1. スクリプトを実行:
```bash
python3 speech_test.py
```

2. 利用可能な音声の一覧が表示され、デフォルトのテキストが音声に変換されます。

3. 出力された音声ファイル（output.mp3）を再生:
```bash
afplay output.mp3  # macOSの場合
```

## カスタマイズ

### 異なる音声を使用する場合

```python
# 男性音声を使用
await speak_text(text, voice="ja-JP-KeitaNeural")

# 女性音声を使用（デフォルト）
await speak_text(text, voice="ja-JP-NanamiNeural")
```

### 異なるファイル名で保存する場合

```python
await speak_text(text, output_file="my_speech.mp3")
```

## 利用可能な音声

- ja-JP-NanamiNeural (女性)
- ja-JP-KeitaNeural (男性)

## 注意事項

- インターネット接続が必要です
- 音声の生成には数秒かかる場合があります

## ライセンス

MIT License
