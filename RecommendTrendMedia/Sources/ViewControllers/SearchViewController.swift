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

class SearchViewController: UIViewController {
  
  // MARK: - Properties
  let mediaInfo = MediaInfo()
  let apiService = APIService()
  var movieData: [TvShow] = []
//  var movies: [TvShow] = []
  
  // MARK: - UI
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchTableView: UITableView!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    searchTableView.delegate = self
    searchTableView.dataSource = self
    
    naviConfigure()
    fetchMovieData()
//    movies = apiService.fetchMovieData()
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
    
    if let query = "스파이더맨".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {

      let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
      let header: HTTPHeaders = [
        "X-Naver-Client-Id": "wPzoG0Hr7uwJaGAZVNmi",
        "X-Naver-Client-Secret": "5__OMmfTA9"
      ]
      
      AF.request(url, method: .get, headers: header).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
          let json = JSON(value)
          print("JSON: \(json)")
          
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
    print(#function)
    return movieData.count
//    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
    print(#function)
//    let media = movies[indexPath.row] // apiService
    let media = movieData[indexPath.row] // 이 파일 안에 있는 함수로
    
    cell.searchImageView.kf.setImage(with: URL(string: media.backdropImage), placeholder: UIImage(named: "profile_7"))
//    cell.searchImageView.image = UIImage(named: media.title.replaceTargetsToReplacement([" ", ":"], "_"))
    cell.searchTitleLabel.text = media.title
    cell.searchReleaseDateLabel.text = media.releaseDate
    cell.searchOverviewLabel.text = media.overview
    
    return cell
  }
}
