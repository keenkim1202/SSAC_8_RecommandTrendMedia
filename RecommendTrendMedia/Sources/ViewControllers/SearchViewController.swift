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
  var totalCount = 0
  
  // MARK: - UI
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchTableView: UITableView!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    searchBar.showsCancelButton = true
    
    searchTableView.delegate = self
    searchTableView.dataSource = self
    searchTableView.prefetchDataSource = self
    
    naviConfigure()
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
  func fetchMovieData(query: String) {
    if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {

      let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
      let header: HTTPHeaders = [
        "X-Naver-Client-Id": "wPzoG0Hr7uwJaGAZVNmi",
        "X-Naver-Client-Secret": "5__OMmfTA9"
      ]
      
      // 네트워크 처리는 비동기, 화면에 데이터를 띄우는 작업은 동기로 처리할 것.
      DispatchQueue.global().async {
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
          switch response.result {
          case .success(let value):
            let json = JSON(value)
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
            
            DispatchQueue.main.async { // check!!
              self.searchTableView.reloadData()
            }
            
            
          case .failure(let error):
            print(error)
          }
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
        
        if let text = searchBar.text {
          fetchMovieData(query: text)
        }
        print("prefetched IndexPath: \(indexPath)")
      }
    }
  }

  func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print("최소 - \(indexPaths)")
  }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  // 검색 버튼(키보드 리턴키)을 눌렀을 때 실행
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print(#function)
    if let text = searchBar.text {
      movieData.removeAll()
      startPage = 1
      fetchMovieData(query: text)
    }
  }
  
  // 취소 버튼을 눌렀을 때 실행
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    print(#function)
    movieData.removeAll()
    searchTableView.reloadData()
    searchBar.setShowsCancelButton(false, animated: true)
  }
  
  // 서치바에서 커서가 깜박이기 시작할 때(편집이 시작될 때)
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    print(#function)
    searchBar.setShowsCancelButton(true, animated: true)
  }
}
