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

class AudioPlayer: HasAudioEngine, Playable {
  let engine = AudioEngine()
  var oscillator = Oscillator()
  
  init() {
    oscillator.frequency = 500
    oscillator.amplitude = 0.5
    engine.output = oscillator
  }
  
  func play(for duration: TimeInterval) throws {
    try callSession()
    oscillator.start()
    // MARK: Maybe create await here with duration
  }
  
  func startEngine() throws {
    do {
      try engine.start()
    } catch {
      throw PlayerException.failedToStartEngine
    }
  }
  
  func stopEngine() {
    oscillator.stop()
    engine.stop()
  }
  
  
  // MARK: Maybe add to init
  private func callSession() throws {
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(.playback, options: [.mixWithOthers])
      try session.setActive(true)
    } catch {
      throw PlayerException.failedToConfigureSession
    }
  }
  
}
