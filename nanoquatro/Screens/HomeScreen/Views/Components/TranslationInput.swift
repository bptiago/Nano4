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

  var didPressFinish: () -> Void = {}
  
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
  private(set) lazy var originalLabel: UILabel = Styles.createLabel(
    text: "Texto original"
  )
  
  lazy var inputField: UITextView = {
    let view = UITextView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    view.adjustsFontForContentSizeCategory = true
    
    view.font = .preferredFont(forTextStyle: .title2)
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
    
  private(set) lazy var morseLabel: UILabel = Styles.createLabel(
    text: "Código morse",
    fontColor: .appAccent
  )
  
  lazy var morseText: UILabel = {
    let view = Styles.createLabel(
      text: "...",
      fontSize: .title2,
      fontColor: .appAccentPlaceholder
    )
    view.numberOfLines = 0
    
    return view
  }()
  
  private let divider: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .darkGray
    
    return view
  }()
  
  lazy var saveButton: UIButton = {
    var button = UIButton(type: .system)
    button.tintColor = .appAccent
    button.isEnabled = false
    button.translatesAutoresizingMaskIntoConstraints = false
    button.adjustsImageSizeForAccessibilityContentSizeCategory = false
    
    button.setPreferredSymbolConfiguration(
        UIImage.SymbolConfiguration(pointSize: 24, weight: .regular),
        forImageIn: .normal
    )
    
    button.setImage(
      UIImage(systemName: "checkmark.circle.fill"),
      for: .normal
    )
    
    button.addAction(
      UIAction(handler: { [weak self] _ in
        guard let self = self else { return }
        self.didPressFinish()
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
    addSubview(saveButton)
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
      
      saveButton.centerYAnchor.constraint(equalTo: morseText.centerYAnchor),
      saveButton.trailingAnchor.constraint(equalTo: originalLabel.trailingAnchor),
    ])
  }
}
