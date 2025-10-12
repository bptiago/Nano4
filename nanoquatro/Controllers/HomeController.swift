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
  weak var translationInputHeader: TranslationInput?
  let communicator = MorseCommunicator()
  let hapticEngine = HapticEngine()
  
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
      collectionView: homeView.cardColletionView) { collectionView, indexPath, item in
        
        guard let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: TranslationCell.identifier,
          for: indexPath
        ) as? TranslationCell else {
          fatalError("Could not dequeue cell")
        }
        
        cell.configure(with: item)
        
        return cell
      }
    
    // Add TranslationInput as CollectionView header
    dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
      let kind = UICollectionView.elementKindSectionHeader
      
      let header = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: TranslationInput.reuseIdentifier,
        for: indexPath
      ) as! TranslationInput
      
      header.inputField.delegate = self
      self.translationInputHeader = header
      
      return header
    }
    
  }
  
  private func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, TranslationInfo>()
    snapshot.appendSections([.main])
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
  private func updateSnapshot(with item: TranslationInfo) {
    var snapshot = dataSource.snapshot()
    snapshot.appendItems([item], toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  private func resetMorseText() {
    translationInputHeader?.morseText.text = "..."
    translationInputHeader?.morseText.textColor = .appAccentPlaceholder
  }
  
  private func resetInputField() {
    translationInputHeader?.inputField.textColor = .appFontPlaceholder
    translationInputHeader?.inputField.text = "Digite o texto"
  }
  
  private func updateView() {
    UIView.performWithoutAnimation {
      self.homeView.cardColletionView.collectionViewLayout.invalidateLayout()
      self.homeView.cardColletionView.layoutIfNeeded()
    }
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

extension HomeController: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    if textView.text.isEmpty {
      resetMorseText()
      return
    }
    
    guard let text = textView.text else { return }
    
    let morse = communicator.encode(text)
    translationInputHeader?.morseText.textColor = .appAccent
    translationInputHeader?.morseText.text = morse
    updateView()
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .appFontPlaceholder {
      textView.text = nil
      textView.textColor = .appFont
      return
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      resetInputField()
      return
    }
    
    guard let header = translationInputHeader else { return }
    
    let item = TranslationInfo(
      originalText: header.inputField.text,
      translatedText: header.morseText.text!,
      author: nil
    )
    
    updateSnapshot(with: item)
    resetInputField()
    resetMorseText()
    updateView() // -> Precisa se não a view fica expandida após inserir textos grandes
    
    hapticEngine.vibrate(with: .dash)
  }
  
  func textView(
    _ textView: UITextView,
    shouldChangeTextIn range: NSRange,
    replacementText text: String
  ) -> Bool {
    if text == "\n" {
      textView.resignFirstResponder()
      return false
    }
    
    return true
  }
}
