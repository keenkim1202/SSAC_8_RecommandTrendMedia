//
//  BookViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/21.
//

import UIKit

class BookViewController: UIViewController {
  
  // MARK: UI
  @IBOutlet weak var bookCollectionView: UICollectionView!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bookCollectionView.delegate = self
    bookCollectionView.dataSource = self
    
    setBookCollectionViewFlowLayout()
  }
  
  func setBookCollectionViewFlowLayout() {
    let layout = UICollectionViewFlowLayout()
    let spacing: CGFloat = 8
    let width = UIScreen.main.bounds.width - (spacing * 4)
    layout.itemSize = CGSize(width: width / 2, height: width / 2)
    layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    bookCollectionView.collectionViewLayout = layout
  }
}

// MARK: Extension - UICollectionViewDelegate
extension BookViewController: UICollectionViewDelegate {
}

// MARK: Extension - UICollectionViewDataSource
extension BookViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
    cell.contentView.backgroundColor = .ramdomColor
    cell.bookRateLabel.tintColor = .white
    cell.contentView.layer.cornerRadius = CGFloat(15)
    return cell
  }
  
}
