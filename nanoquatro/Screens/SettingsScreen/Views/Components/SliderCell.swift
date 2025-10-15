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
    view.maximumValue = 0.5
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
      slider.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      slider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      slider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      
      valueLabel.topAnchor.constraint(equalTo: slider.topAnchor),
      valueLabel.bottomAnchor.constraint(equalTo: slider.bottomAnchor),
      valueLabel.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 8),
      valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
}
