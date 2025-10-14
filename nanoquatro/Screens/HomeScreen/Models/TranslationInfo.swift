//
//  CardInfo.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 08/10/25.
//

import Foundation

struct TranslationInfo: Identifiable, Hashable {
  let id = UUID()
  let originalText: String
  let translatedText: String
  let author: String?
}
