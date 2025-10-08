//
//  ViewController.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 08/10/25.
//

import UIKit

class HomeController: UIViewController {
  
  // MARK: - Properties
  let homeView = HomeScreen()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = homeView
  }
  
  override func loadView() {
  }
  
}
