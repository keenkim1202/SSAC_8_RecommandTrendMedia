//
//  DetailTableViewCell.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
  static let identifier: String = "detailCell"
  
  @IBOutlet weak var detailImageView: UIImageView!
  @IBOutlet weak var detailTitleLabel: UILabel!
  @IBOutlet weak var detailSubtitleLabel: UILabel!
  
  func cellConfigure() {
    detailImageView.layer.cornerRadius = CGFloat(8)
  }
}
