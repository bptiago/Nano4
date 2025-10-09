//
//  HomeScreen.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 08/10/25.
//

import Foundation
import UIKit

class HomeScreen: UIView {
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
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 16
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
  }
  
  private func addSubviews() {
    addSubview(cardColletionView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      cardColletionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      cardColletionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      cardColletionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      cardColletionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
