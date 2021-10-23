//
//  SearchViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit

class SearchViewController: UIViewController {
  
  // MARK: Properties
  let mediaInfo = MediaInfo()
  var titleSpace: String?
  
  // MARK: UI
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchTableView: UITableView!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    searchTableView.delegate = self
    searchTableView.dataSource = self
    
    naviConfigure()
  }
  
  func naviConfigure() {
    title = titleSpace
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(vcDismiss))
    navigationItem.leftBarButtonItem?.tintColor = .systemRed
  }
  
  @objc func vcDismiss() {
     self.navigationController?.popViewController(animated: true)
   }
  
  func convertTitleToImageName(_ base: String, _ occurrences: [String]) -> String {
    var converted = base
    for occurrence in occurrences {
      converted = converted.replacingOccurrences(of: String(occurrence), with: "_")
    }
    return converted
  }
}

// MARK: Extension - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

// MARK: Extension - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mediaInfo.tvShow.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
    let media = mediaInfo.tvShow[indexPath.row]
    cell.searchImageView.image = UIImage(named: convertTitleToImageName(media.title, [" ", ":"]))
    cell.searchTitleLabel.text = media.title
    cell.searchReleaseDateLabel.text = media.releaseDate
    cell.searchOverviewLabel.text = media.overview
    
    return cell
  }
}
