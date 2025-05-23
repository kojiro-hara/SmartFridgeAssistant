import asyncio
import edge_tts

async def speak_text(text, voice="ja-JP-NanamiNeural", output_file="output.mp3"):
    """
    テキストを音声に変換して保存する関数
    
    Parameters:
    - text: 読み上げるテキスト
    - voice: 使用する音声（デフォルトは日本語女性音声）
    - output_file: 出力ファイル名
    """
    try:
        # 音声合成の設定
        communicate = edge_tts.Communicate(text, voice)
        
        # 音声を生成して保存
        await communicate.save(output_file)
        print(f"音声ファイルを保存しました: {output_file}")
        
    except Exception as e:
        print(f"エラーが発生しました: {e}")

async def main():
    # テスト用のテキスト
    text = "こんにちは、これはテストです。今日の給食はカレーライスです。"
    
    # 利用可能な音声の一覧を表示
    voices = await edge_tts.list_voices()
    japanese_voices = [v for v in voices if v["Locale"].startswith("ja-JP")]
    print("\n利用可能な日本語音声:")
    for voice in japanese_voices:
        print(f"- {voice['ShortName']}: {voice['Gender']}")
    
    # 音声を生成
    await speak_text(text)

if __name__ == "__main__":
    asyncio.run(main()) 