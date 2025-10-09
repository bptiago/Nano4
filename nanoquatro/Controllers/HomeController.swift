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
    
    homeView.cardColletionView.delegate = self
    
    configureNavigationBar()
    configureDataSource()
    applyInitialSnapshot()
  }
  
  override func loadView() {
    self.view = homeView
  }
  
  private func configureNavigationBar() {
    title = "Traduzir"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .automatic
    
    let appearance = UINavigationBarAppearance()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.appFont]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.appFont]
    appearance.backgroundColor = .appPrimary
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, TranslationInfo>(
      collectionView: homeView.cardColletionView
    ) {
      collectionView,
      indexPath,
      item in
      
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TranslationCell.identifier,
        for: indexPath
      ) as? TranslationCell else {
        fatalError("Could not dequeue cell")
      }
      
      cell.configure(with: item)
      
      return cell
    }
  }
  
  private func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, TranslationInfo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(
      [
        TranslationInfo(
          originalText: "Asd",
          translatedText: "...---...",
          author: nil
        )
      ]
    )
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    return CGSize(
      width: width,
      height: UICollectionViewFlowLayout.automaticSize.height
    )
  }
}
