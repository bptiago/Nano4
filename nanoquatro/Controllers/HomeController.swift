//
//  ViewController.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 08/10/25.
//

import UIKit

enum Section {
  case main
}

class HomeController: UIViewController {
  
  // MARK: - Properties
  let homeView = HomeScreen()
  var dataSource: UICollectionViewDiffableDataSource<Section, TranslationInfo>!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.barStyle = .black
    
    homeView.cardColletionView.delegate = self
    configureDataSource()
    applyInitialSnapshot()
  }
  
  override func loadView() {
    self.view = homeView
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, TranslationInfo>(
      collectionView: homeView.cardColletionView
    ) {
      collectionView,
      indexPath,
      item in
      
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TranslationCell.identifier,
        for: indexPath
      )
      
      return cell
    }
  }
  
  private func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, TranslationInfo>()
    snapshot.appendSections([.main])
    snapshot.appendItems([
      TranslationInfo(text: "Hello"),
      TranslationInfo(text: "World"),
      TranslationInfo(text: "Morse"),
    ])
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    return CGSize(width: width, height: 500)
  }
}
