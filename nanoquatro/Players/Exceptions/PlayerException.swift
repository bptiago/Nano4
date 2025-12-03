//
//  PlayerError.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 23/10/25.
//

import Foundation

enum PlayerException: Error {
  case hapticsNotSupported
  case failedToConfigureSession
  case failedToCreateEngine
  case failedToStartEngine
  case failedToPlay
}

