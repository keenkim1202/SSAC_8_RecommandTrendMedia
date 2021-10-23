//
//  BookViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/21.
//

import UIKit

class BookViewController: UIViewController {
  
  // MARK: - Properties
  let mediaInfo = MediaInfo()
  
  // MARK: - UI
  @IBOutlet weak var bookCollectionView: UICollectionView!
  
  // MARK: - View Life-Cycle
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

// MARK: Extension
// MARK: - UICollectionViewDelegate
extension BookViewController: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource
extension BookViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mediaInfo.tvShow.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
    cell.cellConfigure()
    
    let media = mediaInfo.tvShow[indexPath.row]
    cell.bookCoverImageView.image = UIImage(named: media.title.replaceTargetsToReplacement([" ", ":"], "_"))
    cell.bookTitleLabel.text = media.title
    cell.bookRateLabel.text = "\(media.rate)"
    
    return cell
  }
}
