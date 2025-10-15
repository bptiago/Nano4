//
//  UserSettings.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 15/10/25.
//

import Foundation

class UserSettings {
  private let userDefaults = UserDefaults.standard

  private let hasUsedAppBeforeKey = "hasUsedAppBefore"
  private let ditDurationKey = "ditDuration"
  private let useVibrationKey = "useVibration"
  
  private var ditDuration: Double
  private var useVibration: Bool
  
  init () {
    let hasUsedAppBefore = userDefaults.bool(forKey: hasUsedAppBeforeKey)
    if !hasUsedAppBefore {
      userDefaults.set(true, forKey: hasUsedAppBeforeKey)
      userDefaults.set(0.1, forKey: ditDurationKey)
      userDefaults.set(true, forKey: useVibrationKey)
    }

    self.ditDuration = userDefaults.object(forKey: ditDurationKey) as! Double
    self.useVibration = userDefaults.bool(forKey: useVibrationKey)
  }
  
  func reloadUserSettings() {
    self.ditDuration = userDefaults.object(forKey: ditDurationKey) as! Double
    self.useVibration = userDefaults.bool(forKey: useVibrationKey)
  }
  
  func setDitDuration(with value: Double) {
    if value <= 0 { return }
    userDefaults.set(value, forKey: ditDurationKey)
  }
  
  func setUseVibration(with value: Bool) {
    userDefaults.set(value, forKey: useVibrationKey)
  }
  
  func getDitDuration() -> Double {
    return ditDuration
  }
  
  func getUseVibration() -> Bool {
    return useVibration
  }
  
}
