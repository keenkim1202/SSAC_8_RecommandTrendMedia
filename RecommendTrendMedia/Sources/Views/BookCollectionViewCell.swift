//
//  BookCollectionViewCell.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/21.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
  static let identifier: String = "bookCell"
  
  @IBOutlet weak var bookTitleLabel: UILabel!
  @IBOutlet weak var bookCoverImageView: UIImageView!
  @IBOutlet weak var bookRateLabel: UILabel!
  
  func cellConfigure() {
    self.contentView.backgroundColor = .ramdomColor
    self.bookRateLabel.tintColor = .white
    self.contentView.layer.cornerRadius = CGFloat(15)
  }
}
