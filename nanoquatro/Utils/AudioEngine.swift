//
//  AudioEngine.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 16/10/25.
//

import Foundation
import AVFoundation

class AudioEngine {
  
  let engine = AVAudioEngine()
  let sampleRate: Double = 44100
  let frequency: Double = 400
  private var theta: Double = 0
  
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
  
  private func setupEngine(with node: AVAudioNode) {
    engine.attach(node)
    let audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
    engine.connect(node, to: engine.mainMixerNode, format: audioFormat)
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
  
  func play() {
    callSession()
    
    let totalSamples = sampleRate //multiplicar por tempo (t) dps
    let thetaIncrement = 2 * Double.pi * frequency * 1 / totalSamples
    
    let audioNode = AVAudioSourceNode { _, _, frameCount, audioBufferList in
      let pointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
      
      for frame in 0..<Int(frameCount) {
        let amplitude = sin(self.theta)
        self.theta += thetaIncrement
        if self.theta > 2 * Double.pi {
          self.theta = 0
        }
        
        for buffer in pointer {
          let buf = UnsafeMutableBufferPointer<Float>(buffer)
          buf[frame] = Float(amplitude)
        }
        
      }
      
      return noErr
    }
    
    setupEngine(with: audioNode)
    startEngine()
    Task {
      sleep(2)
      stopEngine()
    }
  }
  
}

