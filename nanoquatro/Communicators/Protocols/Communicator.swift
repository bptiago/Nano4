//
//  Communicator.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 23/10/25.
//

protocol Communicator {
  func encode(_ text: String) -> String
  func play(_ text: String) async throws -> Void
  //  func decode(_ text: String) -> String
  //  func send() -> TranslationInfo
}
