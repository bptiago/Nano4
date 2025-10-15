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
  let homeView = HomeView()
  let communicator = MorseCommunicator()
  var dataSource: UICollectionViewDiffableDataSource<Section, TranslationInfo>!
  weak var translationInputHeader: TranslationInput?
  
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
  }
  
  private func configureNavigationBar() {
    title = "Traduzir"
    
    let appearance = UINavigationBarAppearance()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.appFont]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.appFont]
    appearance.backgroundColor = .appPrimary
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationController?.navigationBar.tintColor = .appAccent
    
    let settingsButton = UIBarButtonItem(
      image: UIImage(systemName: "gear"),
      style: .plain,
      target: self,
      action: #selector(didClickSettingsButton)
    )
    settingsButton.tintColor = .appAccent
    
    navigationItem.rightBarButtonItem = settingsButton
  }
  
  @objc
  private func didClickSettingsButton() {
    let vc = SettingsController()
    navigationController?.pushViewController(vc, animated: true)
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
        cell.didPressPlay = { [weak self, weak cell] in
          guard let self = self, let cell = cell else { return }
          let text = cell.morseText.text!
          playMorseInHaptic(with: text)
        }
        
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
      header.didPressFinish = { [weak self, weak header] in
        guard let self = self, let header = header else { return }
        guard let morseText = header.morseText.text, let inputText = header.inputField.text else { return }
        if morseText.isEmpty { return }
        
        let item = TranslationInfo(originalText: inputText, translatedText: morseText, author: nil)
        
        updateSnapshot(with: item)
        resetInputField()
        resetMorseText()
        translationInputHeader?.saveButton.isEnabled = false
        view.endEditing(true)
      }
      
      return header
    }
    
  }
  
  private func playMorseInHaptic(with text: String) {
    Task {
      do { try await self.communicator.play(text) }
      catch {
        // Mostrar aviso ou toast caso dê errado
        print(error.localizedDescription)
      }
    }
  }
  
  private func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, TranslationInfo>()
    snapshot.appendSections([.main])
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
  private func updateSnapshot(with item: TranslationInfo) {
    if item.originalText == "Digite o texto" || item.translatedText == "..." {
      return
    }
    
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
      translationInputHeader?.saveButton.isEnabled = false
      resetMorseText()
      return
    }
    
    guard let text = textView.text else { return }
    
    let morse = communicator.encode(text)
    translationInputHeader?.saveButton.isEnabled = true
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
    let inputText = textView.text!
    let morseText = header.morseText.text!
    
    let item = TranslationInfo(
      originalText: inputText,
      translatedText: morseText,
      author: nil
    )
    
    updateSnapshot(with: item)
    resetInputField()
    resetMorseText()
    translationInputHeader?.saveButton.isEnabled = false
    updateView() // -> Precisa se não a view fica expandida após inserir textos grandes
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
