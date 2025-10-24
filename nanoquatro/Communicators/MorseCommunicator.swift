//
//  MorseEncoder.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 12/10/25.
//

import Foundation

class MorseCommunicator: Communicator {
  private var userSettings = UserSettings()
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
  private var unit: Double// base time
  
  init() {
    self.unit = userSettings.getDitDuration()
  }
  
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
    userSettings.reloadUserSettings()
    setUnit(userSettings.getDitDuration())
    
    let factory = PlayerFactory()
    let player = try factory.createPlayer()
    
    for c in text {
      try player.startEngine()
      switch c {
      case "-":
        try player.play(for: 3 * unit)
        // MARK: Maybe use delay inside play function
        try await Task.sleep(nanoseconds: UInt64(unit * 3 * 1_000_000_000))
      case ".":
        try player.play(for: unit)
        try await Task.sleep(nanoseconds: UInt64(unit * 1 * 1_000_000_000))
      case " ":
        try await Task.sleep(nanoseconds: UInt64(unit * 7 * 1_000_000_000))
      default: continue
      }
      player.stopEngine()
      try await Task.sleep(nanoseconds: UInt64(unit * 3 * 1_000_000_000))
    }
    
  }
}
