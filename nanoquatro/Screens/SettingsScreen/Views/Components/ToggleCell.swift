//
//  ToggleCell.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 15/10/25.
//

import Foundation
import UIKit

class ToggleCell: UITableViewCell {
  static let reuseIdentifier = "ToggleCell"

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
  var titleLabel: UILabel = Styles.createLabel(text: "Vibração")
  
  var toggleSwitch: UISwitch = {
    let view = UISwitch()
    view.tintColor = .appAccent
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  // MARK: - Setup Methods
  func configure(with shouldVibrate: Bool) {
    toggleSwitch.isOn = shouldVibrate
  }
  
  private func addSubviews() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(toggleSwitch)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      toggleSwitch.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
      toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      toggleSwitch.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

      titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
      titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),

      contentView.bottomAnchor.constraint(greaterThanOrEqualTo: toggleSwitch.bottomAnchor, constant: 8),
      contentView.bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 8)
    ])
  }
}
