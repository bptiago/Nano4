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
  var slider: UISlider = {
    let view = UISlider()
    view.minimumValue = 0
    view.maximumValue = 1
    view.translatesAutoresizingMaskIntoConstraints = false
    view.tintColor = .appAccent
    
    return view
  }()
  
  lazy var titleLabel: UILabel = Styles.createLabel(
    text: "Duração"
  )
  
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
      
      slider.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      slider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      slider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      slider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
    ])
  }
}
