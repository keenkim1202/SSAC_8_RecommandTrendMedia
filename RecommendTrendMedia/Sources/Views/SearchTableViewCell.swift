//
//  SearchTableViewCell.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
  static let identifier: String = "searchCell"
  
  @IBOutlet weak var searchImageView: UIImageView!
  @IBOutlet weak var searchTitleLabel: UILabel!
  @IBOutlet weak var searchSubtitleLabel: UILabel!
  @IBOutlet weak var searchOverviewLabel: UILabel!
}
