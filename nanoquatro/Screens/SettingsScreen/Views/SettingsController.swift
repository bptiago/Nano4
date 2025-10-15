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
  let userSettings = UserSettings()
  let settings: [SettingsType] = [.slider, .toggle]
  
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
    
//    navigationItem.backBarButtonItem?.action
    
  }
  
//  private func saveSettings() {
//    
//  }
}

extension SettingsController: UITableViewDelegate {}

extension SettingsController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    settings.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let setting = settings[indexPath.section]
    
    if setting == .toggle {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ToggleCell.reuseIdentifier) as? ToggleCell else {
        fatalError("Unable to dequeue cell")
      }
      
      cell.configure(with: userSettings.getUseVibration())
      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SliderCell.reuseIdentifier) as? SliderCell else {
        fatalError("Unable to dequeue cell")
      }
      
      cell.configure(with: Float(userSettings.getDitDuration()))
      return cell
    }

  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return switch section {
    case 0:
      "Duração de unidade de tempo (dit)"
    default:
      nil
    }
    
  }

  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return switch section {
    case 0:
      "Ao ajustar o tempo de um dit, é possível controlar a velocidade de reprodução de mensagens em Morse, tornando-a mais rápida ou lenta."
    case 1:
      "Troca o modo de transmissão do Morse entre vibração ou áudio."
    default:
       nil
    }
  }
  
}
