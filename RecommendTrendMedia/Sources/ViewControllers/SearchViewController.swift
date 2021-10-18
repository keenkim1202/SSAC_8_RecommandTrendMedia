//
//  SearchViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit

class SearchViewController: UIViewController {
  
  // MARK: Properties
  var titleSpace: String?
  
  // MARK: UI
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchTableView: UITableView!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    searchTableView.delegate = self
    searchTableView.dataSource = self
    
    title = titleSpace
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(vcDismiss))
    navigationItem.leftBarButtonItem?.tintColor = .systemRed
  }
  
  @objc func vcDismiss() {
     self.navigationController?.popViewController(animated: true)
   }
}

// MARK: Extension - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
}

// MARK: Extension - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
   // TODO: cell configure
    return cell
  }
}
