//
//  TrendViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit

class TrendViewController: UIViewController {
  
  // MARK: Properties
  let mediaInfo = MediaInfo()
  let profileBackgroundImages: [String] = [
    "profile_1", "profile_2", "profile_3", "profile_4",
    "profile_5", "profile_6", "profile_7", "profile_8"
  ]
  
  // MARK: UI
  @IBOutlet weak var trendTableView: UITableView!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: Action
  @IBAction func onSearchButton(_ sender: UIBarButtonItem) {
    guard let searchVC = storyboard?.instantiateViewController(withIdentifier: "searchVC") as? SearchViewController else { return }
    searchVC.titleSpace = "영화 검색"
    self.navigationController?.pushViewController(searchVC, animated: true)
  }
  
}

// MARK: Extension
// MARK: - UITableViewDelegate
extension TrendViewController: UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.section == 0 ? 220 : 450
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.section, indexPath.row)
  }
}

// MARK: - UITableViewDataSource
extension TrendViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : mediaInfo.tvShow.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let medias = mediaInfo.tvShow[indexPath.row]
    
    if indexPath.section == 0 {
      guard let cell = trendTableView.dequeueReusableCell(withIdentifier: "userCell") as? TrendTableViewCell else { return UITableViewCell() }
      let backgroundImage = profileBackgroundImages.randomElement() ?? "bookmark.fill"
      cell.userCellConfigure()
      cell.userBackgroundImageView.image = UIImage(named: backgroundImage)
      cell.userLabel.text = "hi! user."
      return cell
    } else {
      guard let cell = trendTableView.dequeueReusableCell(withIdentifier: "trendCell") as? TrendTableViewCell else { return UITableViewCell() }
      cell.trendCellConfigure()
      cell.releaseDateLabel.text = medias.releaseDate
      cell.genreLabel.text = "#\(medias.genre)"
      cell.movieTitleLabel.text = medias.title
      cell.backdropImageView.image = UIImage(named: medias.title.replacingOccurrences(of: " ", with: "_"))
      cell.rateLabel.text = "\(medias.rate)"
      cell.starringLabel.text = medias.starring
      
      return cell
    }
  }
}
