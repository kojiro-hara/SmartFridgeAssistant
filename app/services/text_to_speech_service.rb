require 'voicevox-client'

class TextToSpeechService
  def self.generate_speech(text)
    client = VoicevoxClient.new('http://localhost:50021')

    # 音声合成のパラメータを設定
    params = {
      text: text,
      speaker: 1,  # ずんだもん（VOICEVOXのデフォルト音声）
      speed: 1.0,  # 話速
      pitch: 0.0,  # 音の高さ
      intonation: 1.0  # 抑揚
    }

    # 音声を生成
    audio_data = client.tts(params)

    # 一時ファイルに音声データを保存
    temp_file = Tempfile.new(['speech', '.wav'])
    temp_file.binmode
    temp_file.write(audio_data)
    temp_file.rewind

    temp_file
  end

  def self.generate_lunch_announcement(school_lunch)
    text = <<~TEXT
      #{school_lunch.date.strftime('%m月%d日')}の給食は
      主菜は#{school_lunch.main_dish}です。
      副菜は#{school_lunch.side_dish}です。
      スープは#{school_lunch.soup}です。
      #{school_lunch.dessert.present? ? "デザートは#{school_lunch.dessert}です。" : ""}
      カロリーは#{school_lunch.calories}キロカロリーです。
    TEXT

    generate_speech(text)
  end

  def self.generate_event_announcement(school_event)
    text = <<~TEXT
      #{school_event.title}についてお知らせします。
      #{school_event.description}
      期間は#{school_event.start_date.strftime('%m月%d日')}から
      #{school_event.end_date.strftime('%m月%d日')}までです。
      #{school_event.location.present? ? "場所は#{school_event.location}です。" : ""}
    TEXT

    generate_speech(text)
  end
end 