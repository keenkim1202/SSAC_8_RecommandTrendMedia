//
//  TrendTableViewCell.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit

class TrendTableViewCell: UITableViewCell {
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var userBackgroundImageView: UIImageView!
  @IBOutlet weak var menuCardView: UIView!
  
  
  @IBOutlet weak var movieButton: UIButton!
  @IBOutlet weak var tvButton: UIButton!
  @IBOutlet weak var bookButton: UIButton!
  
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var rateLabel: UILabel!
  @IBOutlet weak var movieTitleLabel: UILabel!
  @IBOutlet weak var starringLabel: UILabel!
  
  @IBOutlet weak var posterCardView: UIView!
  @IBOutlet weak var movieInfoCardView: UIView!
  
  func setViewShadow(_ view: UIView) {
    view.layer.shadowOpacity = 0.5
    view.layer.shadowRadius = CGFloat(10)
  }
  
  func userCellConfigure() {
    menuCardView.layer.cornerRadius = CGFloat(8)
    setViewShadow(menuCardView)
  }
  
  func trendCellConfigure() {
    posterCardView.layer.cornerRadius = CGFloat(8)
    movieInfoCardView.layer.cornerRadius = CGFloat(8)
    backdropImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // 위만 둥글게
    posterCardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // 위만 둥글게
    movieInfoCardView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // 아래만 둥글게
    setViewShadow(movieInfoCardView)
  }
}
