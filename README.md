# SmartFridgeAssistant

スマート冷蔵庫アシスタントの音声合成機能を実装するためのPythonスクリプトです。

## 機能

- テキストを自然な音声に変換
- 複数の日本語音声（男性/女性）から選択可能
- MP3形式で音声ファイルを出力

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
- users 1:1 voice_settings

### インデックス

- users: email
- items: refrigerator_id, expiry_date
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
