//
//  MorseEncoder.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 12/10/25.
//

import Foundation

protocol Communicator {
  func encode(_ text: String) -> String
  func play(_ text: String) async throws -> Void
  //  func decode(_ text: String) -> String
  //  func send() -> TranslationInfo
}

class MorseCommunicator: Communicator {
  private var hapticEngine = HapticEngine()
  private let chars: [Character: String] = [
    "A": ".-",    "B": "-...",  "C": "-.-.",
    "D": "-..",   "E": ".",     "F": "..-.",
    "G": "--.",   "H": "....",  "I": "..",
    "J": ".---",  "K": "-.-",   "L": ".-..",
    "M": "--",    "N": "-.",    "O": "---",
    "P": ".--.",  "Q": "--.-",  "R": ".-.",
    "S": "...",   "T": "-",     "U": "..-",
    "V": "...-",  "W": ".--",   "X": "-..-",
    "Y": "-.--",  "Z": "--..",
    "1": ".----", "2": "..---", "3": "...--",
    "4": "....-", "5": ".....", "6": "-....",
    "7": "--...", "8": "---..", "9": "----.",
    "0": "-----", " ": "  "
  ]
  
  // Real Morse timing (i.e. dot = 1 unit, dash = 3 units,
  // inter-letter = 3 units, inter-word = 7 units)
  private var unit: Double = 0.1 // base time
  
  func setUnit(_ unit: Double) {
    self.unit = unit
  }
  
  func encode(_ text: String) -> String {
    let morse = text.uppercased().compactMap { c in
      chars[c]
    }
    
    return morse.joined()
  }
  
  func play(_ text: String) async throws {
    try hapticEngine.startEngine()
    
    for c in text {
      switch c {
      case "-":
        hapticEngine.vibrate(for: 3 * unit)
        try await Task.sleep(nanoseconds: UInt64(unit * 3 * 1_000_000_000))
      case ".":
        hapticEngine.vibrate(for: unit)
        try await Task.sleep(nanoseconds: UInt64(unit * 1 * 1_000_000_000))
      case " ":
        try await Task.sleep(nanoseconds: UInt64(unit * 7 * 1_000_000_000))
      default: continue
      }
      
      try await Task.sleep(nanoseconds: UInt64(unit * 2 * 1_000_000_000))
    }
    
    hapticEngine.stopEngine()
  }
}
