//
//  Styles.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 14/10/25.
//

import Foundation
import UIKit

class Styles {
  static func createLabel(
    text: String = "",
    fontSize: UIFont.TextStyle = .callout,
    fontColor: UIColor = .appFont
  ) -> UILabel {
    let view = UILabel()
    
//    view.font = .systemFont(ofSize: fontSize, weight: .semibold)
    view.font = .preferredFont(forTextStyle: fontSize)
    view.text = text
    view.textColor = fontColor
    view.translatesAutoresizingMaskIntoConstraints = false
    view.adjustsFontForContentSizeCategory = true
    
    return view
  }
}
