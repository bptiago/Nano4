//
//  HapticEngine.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 12/10/25.
//

import Foundation
import CoreHaptics

class HapticPlayer: Playable {
  private var engine: CHHapticEngine!
  private var supportsHaptics: Bool
  
  init() throws {
    let capabilities = CHHapticEngine.capabilitiesForHardware()
    self.supportsHaptics = capabilities.supportsHaptics
    
    guard supportsHaptics else { throw PlayerException.hapticsNotSupported }
    
    do {
      engine = try CHHapticEngine()
      resetHandler()
      stopHandler()
    } catch {
      throw PlayerException.failedToCreateEngine
    }
  }
  
  func play(for duration: TimeInterval) throws {
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
        duration: duration
      )
      let pattern = try CHHapticPattern(events: [event], parameters: [])
      let player = try engine.makePlayer(with: pattern)
      try player.start(atTime: 0)
    } catch {
      throw PlayerException.failedToPlay
    }
  }
  
  func startEngine() throws {
    do {
      try engine.start()
    } catch {
      throw PlayerException.failedToStartEngine
    }
  }
  
  func stopEngine() {
    engine.notifyWhenPlayersFinished { error in
      return .stopEngine
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
