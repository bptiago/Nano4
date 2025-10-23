//
//  AudioEngine.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 23/10/25.
//

import Foundation
import AudioKit
import SoundpipeAudioKit
import AVFoundation

class AudioPlayer: HasAudioEngine {
  let engine = AudioEngine()
  var oscillator = Oscillator()
  
  init() {
    oscillator.frequency = 500
    oscillator.amplitude = 0.5
    engine.output = oscillator
  }
  
  func play() {
    callSession()
    startEngine()
    oscillator.start()
  }
  
  func stop() {
    oscillator.stop()
    engine.stop()
  }
  
  private func startEngine() {
    do {
      try engine.start()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func stopEngine() {
    engine.stop()
  }
  
  private func callSession() {
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(.playback, options: [.mixWithOthers])
      try session.setActive(true)
    } catch {
      print("Audio session error: \(error.localizedDescription)")
    }
  }
  
}
