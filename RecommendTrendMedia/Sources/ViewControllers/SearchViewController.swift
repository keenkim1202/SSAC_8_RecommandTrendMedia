//
//  SearchViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

// MARK: TableView Prefetch 추가하여 pagination 기능 구현 - 10/27

class SearchViewController: UIViewController {
  
  // MARK: - Properties
  let mediaInfo = MediaInfo()
  let apiService = APIService()
  var movieData: [TvShow] = []
  
  var startPage = 1
  
  // MARK: - UI
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchTableView: UITableView!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    searchTableView.delegate = self
    searchTableView.dataSource = self
    searchTableView.prefetchDataSource = self
    
    naviConfigure()
    fetchMovieData()
  }
  
  // MARK: - Configure
  func naviConfigure() {
    self.title = "영화 검색"
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(vcDismiss))
    navigationItem.leftBarButtonItem?.tintColor = .systemRed
  }
  
  @objc func vcDismiss() {
     self.navigationController?.popViewController(animated: true)
   }
  
  // MARK: - API 네이버 영화검색
  func fetchMovieData() {
    if let query = "사랑".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {

      let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
      let header: HTTPHeaders = [
        "X-Naver-Client-Id": "wPzoG0Hr7uwJaGAZVNmi",
        "X-Naver-Client-Secret": "5__OMmfTA9"
      ]
      
      AF.request(url, method: .get, headers: header).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
          let json = JSON(value)
//          print("JSON: \(json)")
          let items = json["items"].arrayValue
          
          for item in items {
            let title = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
            let image = item["image"].stringValue
//            let link = item["link"].stringValue
            let userRating = item["userRating"].doubleValue
//            let sub = item["subTitle"].stringValue
            let actor = item["actor"].stringValue
            let pubDate = item["pubDate"].stringValue
            
            let data = TvShow(
              title: title,
              releaseDate: pubDate,
              genre: "장르",
              region: "지역",
              overview: "줄거리",
              rate: userRating,
              starring: actor,
              backdropImage: image)
            
            self.movieData.append(data)
            print(value)
          }
          self.searchTableView.reloadData()
          
        case .failure(let error):
          print(error)
        }
      }
    }
  }
}

// MARK: Extension
// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
    let media = movieData[indexPath.row] // 이 파일 안에 있는 함수로
    
    cell.searchImageView.kf.setImage(with: URL(string: media.backdropImage), placeholder: UIImage(named: "profile_7"))
//    cell.searchImageView.image = UIImage(named: media.title.replaceTargetsToReplacement([" ", ":"], "_"))
    cell.searchTitleLabel.text = media.title
    cell.searchReleaseDateLabel.text = media.releaseDate
    cell.searchOverviewLabel.text = media.overview
    
    return cell
  }
}

// MARK: - UITableViewDataSourcePrefetching
extension SearchViewController: UITableViewDataSourcePrefetching {
  /// cell이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능 (하나하나가 아니라, 덩어리 형태로)
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
      if movieData.count - 1 == indexPath.row {
        startPage += 10
        fetchMovieData()
        print("prefetched IndexPath: \(indexPath)")
      }
    }
  }
  
  /// 사용자가 엄청 빨리 스크롤을 해서 prefetch할 필요가 없을 때 실행될 것.
  /// 여러개가 취소될 수 있으므로 indexPaths 이다.
  func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print("최소 - \(indexPaths)")
  }
}
