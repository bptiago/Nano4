//
//  SettingsController.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 14/10/25.
//

import Foundation
import UIKit

class SettingsController: UIViewController {
  
  // MARK: - Properties
  let settingsView = SettingsView()
  let settings = ["Slider"]
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    settingsView.tableView.delegate = self
    settingsView.tableView.dataSource = self
    
    configureNavigationBar()
  }
  
  override func loadView() {
    view = settingsView
  }
  
  private func configureNavigationBar() {
    navigationItem.title = "Configurações"
    navigationController?.navigationBar.prefersLargeTitles = false
  }
}

extension SettingsController: UITableViewDelegate {}

extension SettingsController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    settings.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier) as? SettingsCell else {
      fatalError("Unable to dequeue cell")
    }
        
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    "Duração de unidade de tempo (dit)"
  }

  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    "Ao ajustar o tempo de um dit, é possível controlar a velocidade de reprodução de mensagens em Morse, tornando-a mais rápida ou lenta."
  }
  
}
