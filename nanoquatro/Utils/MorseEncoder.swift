//
//  MorseEncoder.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 12/10/25.
//

import Foundation

class MorseEncoder {
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
  
  func encode(_ text: String) -> String {
    let morse = text.uppercased().compactMap { c in
      chars[c]
    }
    
    return morse.joined()
  }
  
}
