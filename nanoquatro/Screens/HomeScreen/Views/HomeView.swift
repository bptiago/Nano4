//
//  HomeScreen.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 08/10/25.
//

import Foundation
import UIKit

class HomeView: UIView {
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubviews()
    setupCollectionView()
    setupConstraints()
    
    backgroundColor = .appPrimary
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: - Subviews
  let cardColletionView: UICollectionView = {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(100) // will expand automatically
    )
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: itemSize,
      subitems: [item]
    )
    
    let headerSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(200)
    )
    
    let header = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: headerSize,
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .top
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [header]
    section.interGroupSpacing = 16
    section.contentInsets.top = 16
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    
    let view = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.showsVerticalScrollIndicator = false
    
    return view
  }()
  
  // MARK: - Setup Methods
  private func setupCollectionView() {
    cardColletionView.register(
      TranslationCell.self,
      forCellWithReuseIdentifier: TranslationCell.identifier
    )
    
    cardColletionView.register(
      TranslationInput.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: TranslationInput.reuseIdentifier
    )
  }
  
  private func addSubviews() {
    addSubview(cardColletionView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      cardColletionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      cardColletionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      cardColletionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      cardColletionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
