//
//  EngineFactory.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 23/10/25.
//

import Foundation

class PlayerFactory {
  
  private let userSettings = UserSettings()
  
  func createEngine() -> Playable {
    let shouldUseVibration = userSettings.getShouldUseVibration()
    return shouldUseVibration ? HapticPlayer() : AudioPlayer()
  }
  
}
