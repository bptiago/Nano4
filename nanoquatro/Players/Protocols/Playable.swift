//
//  Playable.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 23/10/25.
//

import Foundation

protocol Playable {
  func play(for duration: TimeInterval) throws
  // MARK: CALLED ON MORSECOMMUNICATOR
  func startEngine() throws
  // MARK: CALLED ON MORSECOMMUNICATOR
  func stopEngine()
}
