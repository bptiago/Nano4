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
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
      
      toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      toggleSwitch.topAnchor.constraint(equalTo: titleLabel.topAnchor),
      toggleSwitch.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
    ])
  }
}
