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
    text: String = "",
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
    let view = createLabel(fontSize: 24)
    view.numberOfLines = 0
    
    return view
  }()
  
  private(set) lazy var morseLabel: UILabel = createLabel(text: "Código morse", fontColor: .appAccent)
  
  private(set) lazy var morseText: UILabel = {
    let view = createLabel(fontSize: 24, fontColor: .appAccent)
    view.numberOfLines = 0
    
    return view
  }()
  
  private let divider: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .darkGray
    
    return view
  }()
  
  lazy var playButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .appAccent
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(
      UIImage(systemName: "play.circle.fill"),
      for: .normal
    )
    
    button.addAction(
      UIAction(handler: { action in
        print("oi")
      }),
      for: .touchUpInside
    )

    return button
  }()
  
  // MARK: - Setup Methods
  func configure(with item: TranslationInfo) {
    originalText.text = item.originalText
    morseText.text = item.translatedText
  }
  
  private func addSubviews() {
    contentView.addSubview(originalLabel)
    contentView.addSubview(originalText)
    contentView.addSubview(divider)
    contentView.addSubview(morseLabel)
    contentView.addSubview(morseText)
    contentView.addSubview(playButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      originalLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      originalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      originalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      originalText.topAnchor.constraint(equalTo: originalLabel.bottomAnchor, constant: 8),
      originalText.leadingAnchor.constraint(equalTo: originalLabel.leadingAnchor),
      
      divider.heightAnchor.constraint(equalToConstant: 0.5),
      divider.topAnchor.constraint(equalTo: originalText.bottomAnchor, constant: 16),
      divider.trailingAnchor.constraint(equalTo: originalLabel.trailingAnchor),
      divider.leadingAnchor.constraint(equalTo: originalLabel.leadingAnchor),
      
      morseLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
      morseLabel.leadingAnchor.constraint(equalTo: originalLabel.leadingAnchor),
      morseLabel.trailingAnchor.constraint(equalTo: originalLabel.trailingAnchor),
      
      morseText.topAnchor.constraint(equalTo: morseLabel.bottomAnchor, constant: 8),
      morseText.leadingAnchor.constraint(equalTo: morseLabel.leadingAnchor),
      morseText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
      morseText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      
      playButton.centerYAnchor.constraint(equalTo: morseText.centerYAnchor),
      playButton.trailingAnchor.constraint(equalTo: originalLabel.trailingAnchor),
    ])
  }
}
