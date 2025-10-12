//
//  HapticEngine.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 12/10/25.
//

import Foundation
import CoreHaptics

enum HapticType {
  case dash
  case dot
}

class HapticEngine {
  private var engine: CHHapticEngine!
  private var supportsHaptics: Bool
  
  init() {
    let capabilities = CHHapticEngine.capabilitiesForHardware()
    self.supportsHaptics = capabilities.supportsHaptics
    
    if supportsHaptics {
      do {
        engine = try CHHapticEngine()
        resetHandler()
        stopHandler()
      } catch let error {
        fatalError("Engine Creation Error: \(error)")
      }
    }
  }
  
  // Chamar quando der play
  func startEngine() throws {
    try engine.start()
  }
  
  // Chamar quando terminar o código
  func stopEngine() {
    engine.notifyWhenPlayersFinished { error in
      return .stopEngine
    }
  }
  
  func vibrate(with type: HapticType) {
    if !supportsHaptics { return }
    
    do {
      let event = CHHapticEvent(
        eventType: .hapticContinuous,
        parameters: [
          CHHapticEventParameter(
            parameterID: .hapticIntensity,
            value: 1.0
          ),
        ],
        relativeTime: 0,
        duration: type == .dash ? 0.8 : 0.2
      )
      let pattern = try CHHapticPattern(events: [event], parameters: [])
      let player = try engine.makePlayer(with: pattern)
      
      try player.start(atTime: 0)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func resetHandler() {
    engine.resetHandler = {
      print("Reset Handler: Restarting the engine.")
      do {
        try self.engine.start()
      } catch {
        fatalError("Failed to restart the engine: \(error)")
      }
    }
  }
  
  private func stopHandler() {
    engine.stoppedHandler = { reason in
      print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
      switch reason {
      case .audioSessionInterrupt: print("Audio session interrupt")
      case .applicationSuspended: print("Application suspended")
      case .idleTimeout: print("Idle timeout")
      case .systemError: print("System error")
      case .notifyWhenFinished: print("Finished playing haptics")
      case .engineDestroyed: print("Engine destroyed")
      case .gameControllerDisconnect: print("Game controller disconnected")
      @unknown default:
        print("Unknown error")
      }
    }
  }
}
