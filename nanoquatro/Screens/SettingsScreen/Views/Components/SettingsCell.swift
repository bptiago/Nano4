//
//  SettingCell.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 14/10/25.
//

import Foundation
import UIKit

class SettingsCell: UITableViewCell {
  static let reuseIdentifier = "SettingsCell"
  
  // MARK: - Initializers
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.backgroundColor = .appSecondary
    
    addSubviews()
    setupConstraints()
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
  
  var slider: UISlider = {
    let view = UISlider()
    view.minimumValue = 0
    view.maximumValue = 1
    view.translatesAutoresizingMaskIntoConstraints = false
    view.tintColor = .appAccent
    
    return view
  }()
  
  lazy var titleLabel: UILabel = createLabel(text: "Duração")
  
  // MARK: - Setup Methods
  private func addSubviews() {
//    contentView.addSubview(titleLabel)
    contentView.addSubview(slider)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
//      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//      titleLabel.widthAnchor.constraint(equalToConstant: 100),
      
      slider.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      slider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      slider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      slider.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}
