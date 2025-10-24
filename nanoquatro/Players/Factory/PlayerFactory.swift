//
//  EngineFactory.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 23/10/25.
//

import Foundation

class PlayerFactory {
  
  private let userSettings = UserSettings()
  
  func createPlayer() throws -> Playable {
    let shouldUseVibration = userSettings.getShouldUseVibration()
    return shouldUseVibration ? try HapticPlayer() : AudioPlayer()
  }
  
}
