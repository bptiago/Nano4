//
//  UIFont.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 02/12/25.
//

import Foundation
import UIKit

extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let descriptor = fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight
            ]
        ])
        return UIFont(descriptor: descriptor, size: 0)
    }
}
