//
//  DetailViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit

class DetailViewController: UIViewController {
  
  // MARK: UI
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var detailTableView: UITableView!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    detailTableView.delegate = self
    detailTableView.dataSource = self
  }
  
}

// MARK: Extension - TableViewDelegate
extension DetailViewController: UITableViewDelegate {
}

// MARK: Extension - TableViewDataSource
extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10 // dummy
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as? DetailTableViewCell else { return UITableViewCell() }
    // cell configure
    return cell
  }
  
  
}
