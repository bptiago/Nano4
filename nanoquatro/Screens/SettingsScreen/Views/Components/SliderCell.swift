//
//  SettingCell.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 14/10/25.
//

import Foundation
import UIKit

class SliderCell: UITableViewCell {
  static let reuseIdentifier = "SliderCell"
  
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
  lazy var slider: UISlider = {
    let view = UISlider()
    view.minimumValue = 0.05
    view.maximumValue = 0.3
    view.translatesAutoresizingMaskIntoConstraints = false
    view.tintColor = .appAccent
    
    view.addTarget(self, action: #selector(updateValueLabel(_:)), for: .valueChanged)
    
    return view
  }()
  
  var valueLabel: UILabel = Styles.createLabel()
  
  // MARK: - Setup Methods
  func configure(with number: Float) {
    slider.setValue(number, animated: true)
    valueLabel.text = String(format: "%.2fs", number)
  }
  
  @objc
  private func updateValueLabel(_ sender: UISlider) {
    valueLabel.text = String(format: "%.2fs", slider.value)
  }
  
  private func addSubviews() {
    contentView.addSubview(slider)
    contentView.addSubview(valueLabel)
  }
  
  private func setupConstraints() {
      NSLayoutConstraint.activate([
          slider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
          slider.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

          valueLabel.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 8),
          valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
          valueLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor),

          slider.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
          valueLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),

          contentView.bottomAnchor.constraint(greaterThanOrEqualTo: slider.bottomAnchor, constant: 8),
          contentView.bottomAnchor.constraint(greaterThanOrEqualTo: valueLabel.bottomAnchor, constant: 8)
      ])
  }

}
