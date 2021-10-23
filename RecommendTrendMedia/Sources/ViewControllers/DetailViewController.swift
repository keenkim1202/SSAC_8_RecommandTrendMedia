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
  var isOpen: Bool = false
  
  // MARK: UI
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var detailTableView: UITableView!
  
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    detailTableView.delegate = self
    detailTableView.dataSource = self
    
    self.title = "출연/제작"
    self.navigationController?.navigationBar.tintColor = .systemRed
    
    if let media = media {
      configureHeaderImage(media)
      starring = media.starring.components(separatedBy: ", ")
    }
    
  }
  
  func configureHeaderImage(_ media: TvShow) {
    headerImageView.kf.setImage(with: URL(string: media.backdropImage), placeholder: UIImage(named: "profile_7"))
    posterImageView.image = UIImage(named: convertTitleToImageName(media.title, [" ", ":"]))
  }
  
  func convertTitleToImageName(_ base: String, _ occurrences: [String]) -> String {
    var converted = base
    for occurrence in occurrences {
      converted = converted.replacingOccurrences(of: String(occurrence), with: "_")
    }
    return converted
  }
  
  // MARK: Action
  @IBAction func onChevronButton(_ sender: UIButton) {
    isOpen.toggle()
    detailTableView.reloadSections(IndexSet(0...0), with: .automatic)
  }
}

// MARK: Extension - TableViewDelegate
extension DetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      if isOpen == false {
        return 80
      } else {
        return tableView.estimatedRowHeight
      }
    } else {
      return 80
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
}

// MARK: Extension - TableViewDataSource
extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else {
      return starring.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
      if let media = media {
        cell.overviewLabel.text = media.overview
        if isOpen == true {
          cell.chevronButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
          cell.chevronButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)

        }
      } else {
        cell.overviewLabel.text = "줄거리 정보를 가져올 수 없습니다."
      }
      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as? DetailTableViewCell else { return UITableViewCell() }
      // 출연진 목록
      cell.detailTitleLabel.text = starring[indexPath.row]
      cell.cellConfigure()
      return cell
    }
  }
}
