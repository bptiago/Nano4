//
//  SettingsView.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 14/10/25.
//

import Foundation
import UIKit

class SettingsView: UIView {
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .appPrimary
    
    setupTableView()
    addSubviews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: - Subviews
  var tableView: UITableView = {
    let view = UITableView(frame: .zero, style: .insetGrouped)
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    view.rowHeight = UITableView.automaticDimension
    view.estimatedRowHeight = 50
    
    return view
  }()
  
  // MARK: - Setup Methods
  private func setupTableView() {
    tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
  }
  
  private func addSubviews() {
    addSubview(tableView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
