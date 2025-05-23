import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["text"]

  connect() {
    this.synthesis = window.speechSynthesis
    // 日本語の音声を取得
    this.voices = this.synthesis.getVoices()
    this.japaneseVoice = this.voices.find(voice => voice.lang === 'ja-JP')
  }

  speak() {
    if (this.synthesis.speaking) {
      this.synthesis.cancel()
    }

    const text = this.textTarget.textContent
    const utterance = new SpeechSynthesisUtterance(text)

    // 日本語の音声を設定
    if (this.japaneseVoice) {
      utterance.voice = this.japaneseVoice
    }
    utterance.lang = 'ja-JP'
    utterance.rate = 1.0
    utterance.pitch = 1.0
    utterance.volume = 1.0

    // 音声の準備ができたら再生
    this.synthesis.speak(utterance)

    // デバッグ用のログ
    console.log('Speaking:', text)
    console.log('Voice:', utterance.voice)
    console.log('Language:', utterance.lang)
  }

  stop() {
    if (this.synthesis.speaking) {
      this.synthesis.cancel()
    }
  }
} 