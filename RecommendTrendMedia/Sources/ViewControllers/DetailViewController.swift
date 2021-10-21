//
//  DetailViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
  // MARK: Properties
  var media: TvShow?
  var starring: [String] = []
  
  // MARK: UI
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var detailTableView: UITableView!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    detailTableView.delegate = self
    detailTableView.dataSource = self
    
    self.navigationController?.navigationBar.tintColor = .systemRed
    
    if let media = media {
      configureHeaderImage(media)
      starring = media.starring.components(separatedBy: ", ")
    }
    
  }
  
  func configureHeaderImage(_ media: TvShow) {
    headerImageView.kf.setImage(with: URL(string: media.backdropImage), placeholder: UIImage(named: "profile_7"))
    posterImageView.image = UIImage(named: media.title)
  }
}

// MARK: Extension - TableViewDelegate
extension DetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}

// MARK: Extension - TableViewDataSource
extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  starring.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as? DetailTableViewCell else { return UITableViewCell() }
    // 출연진 목록
    cell.detailTitleLabel.text = starring[indexPath.row]
    cell.cellConfigure()
    return cell
  }
}
