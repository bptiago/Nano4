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
  
  weak var toggleCell: ToggleCell?
  weak var sliderCell: SliderCell?
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    settingsView.tableView.delegate = self
    settingsView.tableView.dataSource = self
    
    configureNavigationBar()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    saveSettings()
  }
  
  override func loadView() {
    view = settingsView
  }
  
  private func configureNavigationBar() {
    navigationItem.title = "Configurações"
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  private func saveSettings() {
    guard
      let slider = sliderCell?.slider,
      let toggle = toggleCell?.toggleSwitch
    else { return }
    
    let ditDuration = Double(slider.value)
    let useVibration: Bool = toggle.isOn
    
    userSettings.setDitDuration(with: ditDuration)
    userSettings.setUseVibration(with: useVibration)
    dismiss(animated: true)
  }
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
      
      self.toggleCell = cell
      
      cell.configure(with: userSettings.getUseVibration())
      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SliderCell.reuseIdentifier) as? SliderCell else {
        fatalError("Unable to dequeue cell")
      }
      
      self.sliderCell = cell
      
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
