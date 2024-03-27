//
//  TTSManager.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 12/4/23.
//

import Foundation
import AVFoundation

class TTSManager {
	
	static let shared = TTSManager()
	
	private let synthesizer = AVSpeechSynthesizer()
	
	internal func play(_ string: String) {
		let utterance = AVSpeechUtterance(string: string)
		utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
		utterance.rate = 0.4
		synthesizer.stopSpeaking(at: .immediate)
		synthesizer.speak(utterance)
	}
	
	internal func stop() {
		synthesizer.stopSpeaking(at: .immediate)
	}
}
