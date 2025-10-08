//
//  TranslationCell.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 08/10/25.
//

import Foundation
import UIKit

class TranslationCell: UICollectionViewCell {
  // MARK: - Initializers
  static let identifier: String = "TranslationCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubviews()
    setupConstraints()
    contentView.backgroundColor = .appSecondary
    contentView.layer.cornerRadius = 16
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: - Subviews
  private func createLabel(
    text: String,
    fontSize: CGFloat = 16,
    fontColor: UIColor = .appFont
  ) -> UILabel {
    let view = UILabel()
    
    view.font = .systemFont(ofSize: fontSize, weight: .semibold)
    view.text = text
    view.textColor = fontColor
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }
  
  private(set) lazy var originalLabel: UILabel = createLabel(text: "Texto original")
  
  private(set) lazy var originalText: UILabel = {
    let view = createLabel(text: "asd", fontSize: 24)
    view.numberOfLines = 0
    
    return view
  }()
  
  private(set) lazy var morseLabel: UILabel = createLabel(text: "Morse", fontColor: .appAccent)
  
  private(set) lazy var morseText: UILabel = {
    let view = createLabel(text: "asd", fontSize: 24, fontColor: .appAccent)
    view.numberOfLines = 0
    
    return view
  }()
  
  // MARK: - Setup Methods
  private func addSubviews() {
    contentView.addSubview(originalLabel)
    contentView.addSubview(originalText)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      originalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      originalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      originalText.topAnchor.constraint(equalTo: originalLabel.bottomAnchor, constant: 8),
      originalText.leadingAnchor.constraint(equalTo: originalLabel.leadingAnchor)
    ])
  }
}
