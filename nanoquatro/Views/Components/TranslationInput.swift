//
//  TypingCard.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 10/10/25.
//

import Foundation
import UIKit

class TranslationInput: UICollectionReusableView {
  static let reuseIdentifier = "TranslationInput"

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubviews()
    setupConstraints()
    backgroundColor = .appSecondary
    layer.cornerRadius = 16
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
  
  lazy var inputField: UITextView = {
    let view = UITextView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.font = .systemFont(ofSize: 24, weight: .semibold)
    view.textAlignment = .natural
    view.textContainerInset = .zero
    view.textContainer.lineFragmentPadding = 0
    view.text = "Digite o texto" // Placeholder text
    view.textColor = .appFontPlaceholder
    
    view.isScrollEnabled = false
    view.backgroundColor = .clear

    view.keyboardType = .default
    view.returnKeyType = .done
    
    return view
  }()
    
  private(set) lazy var morseLabel: UILabel = createLabel(text: "Código morse", fontColor: .appAccent)
  
  lazy var morseText: UILabel = {
    let view = createLabel(text: "...", fontSize: 24, fontColor: .appAccentPlaceholder)
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
  func configure(with item: String) {
    morseText.text = item
  }
  
  private func addSubviews() {
    addSubview(originalLabel)
    addSubview(inputField)
    addSubview(divider)
    addSubview(morseLabel)
    addSubview(morseText)
    addSubview(playButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      originalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      originalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      originalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      
      inputField.topAnchor.constraint(equalTo: originalLabel.bottomAnchor, constant: 8),
      inputField.leadingAnchor.constraint(equalTo: originalLabel.leadingAnchor),
      inputField.trailingAnchor.constraint(equalTo: originalLabel.trailingAnchor),
      
      divider.heightAnchor.constraint(equalToConstant: 0.5),
      divider.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 16),
      divider.trailingAnchor.constraint(equalTo: originalLabel.trailingAnchor),
      divider.leadingAnchor.constraint(equalTo: originalLabel.leadingAnchor),
      
      morseLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
      morseLabel.leadingAnchor.constraint(equalTo: originalLabel.leadingAnchor),
      morseLabel.trailingAnchor.constraint(equalTo: originalLabel.trailingAnchor),
      
      morseText.topAnchor.constraint(equalTo: morseLabel.bottomAnchor, constant: 8),
      morseText.leadingAnchor.constraint(equalTo: morseLabel.leadingAnchor),
      morseText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
      morseText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
      
      playButton.centerYAnchor.constraint(equalTo: morseText.centerYAnchor),
      playButton.trailingAnchor.constraint(equalTo: originalLabel.trailingAnchor),
    ])
  }
}
