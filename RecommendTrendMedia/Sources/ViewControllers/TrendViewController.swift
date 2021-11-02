//
//  TrendViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/17.
//

import UIKit
import Kingfisher
import JGProgressHUD

// TODO: 장르, 출연진 정보 뿌려주기

class TrendViewController: UIViewController {
  
  // MARK: - Properties
  var mediaInfo = MediaInfo()
  let apiService = APIService()
  let progress = JGProgressHUD()
  
  var movieData: [TvShow] = [] {
    didSet {
      trendTableView.reloadData()
    }
  }
  
  let profileBackgroundImages: [String] = [
    "profile_1", "profile_2", "profile_3", "profile_4",
    "profile_5", "profile_6", "profile_7", "profile_8"
  ]
  
  // MARK: - UI
  @IBOutlet weak var trendTableView: UITableView!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    print("viewDidLoad")
    fetchData()
  }
  
  // MARK: - FetchData
  func fetchData() {
    print("fetchStart")
    progress.show(in: view, animated: true)
    DispatchQueue.global().async {
      APIService.shared.fetchTrendData(mediaType: .movie, timeWindow: .day) { code, json in
        switch code {
        case 200:
          print("fetching..")
          var fetchedData: [TvShow] = []
          let results = json["results"]
          
          results.forEach {
            let title = $0.1["title"].stringValue
            let releaseDate = $0.1["release_date"].stringValue
            //        let genre_ids = results["genre_ids"]
            let region = $0.1["original_language"].stringValue
            let overview = $0.1["overview"].stringValue
            let rate = $0.1["vote_average"].doubleValue
            let backdropPath = $0.1["backdrop_path"].stringValue
            print(rate)
            let media = TvShow(title: title, releaseDate: releaseDate, genre: "장르", region: region, overview: overview, rate: rate, starring: "출연진", backdropImage: "https://image.tmdb.org/t/p/w500\(backdropPath)")
            fetchedData.append(media)
          }
          DispatchQueue.main.async {
            self.movieData += fetchedData
          }
        default:
          print("ERROR: ", code, json)
        }
      }
      self.progress.dismiss(animated: true)
    }
    print("fetchEnd")
  }
  
  // MARK: - Actions
  /// menu button
  @IBAction func onBookMenu(_ sender: UIButton) {
    guard let bookVC = self.storyboard?.instantiateViewController(withIdentifier: "bookVC") as? BookViewController else { return }
    self.navigationController?.pushViewController(bookVC, animated: true)
  }
  
  /// navigationBar Button
  @IBAction func onPinButton(_ sender: UIBarButtonItem) {
    guard let theaterNC = self.storyboard?.instantiateViewController(withIdentifier: "theaterNC") as? UINavigationController else { return }
    
    theaterNC.modalPresentationStyle = .fullScreen
    self.present(theaterNC, animated: true, completion: nil)
  }
  
  @IBAction func onSearchButton(_ sender: UIBarButtonItem) {
    guard let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as? SearchViewController else { return }
    self.navigationController?.pushViewController(searchVC, animated: true)
  }
  
  @IBAction func onWebLinkButton(_ sender: UIButton) {
    guard let webLinkNC = self.storyboard?.instantiateViewController(withIdentifier: "webLinkNC") as? UINavigationController else { return }
    guard let vc = webLinkNC.viewControllers.first as? WebLinkViewController else { return }
    
    vc.navigationTitle = movieData[sender.tag].title
    self.present(webLinkNC, animated: true, completion: nil)
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
    if indexPath.section == 1 {
      guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return }
      detailVC.media = movieData[indexPath.row]
      self.navigationController?.pushViewController(detailVC, animated: true)
    }
  }
}

// MARK: - UITableViewDataSource
extension TrendViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : movieData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.section == 0 {
      guard let cell = trendTableView.dequeueReusableCell(withIdentifier: "userCell") as? TrendTableViewCell else { return UITableViewCell() }
      let backgroundImage = profileBackgroundImages.randomElement() ?? "bookmark.fill"
      
      cell.userCellConfigure()
      cell.userBackgroundImageView.image = UIImage(named: backgroundImage)
      cell.userLabel.text = "hi! user."
      cell.selectionStyle = .none
      return cell
    } else {
      guard let cell = trendTableView.dequeueReusableCell(withIdentifier: "trendCell") as? TrendTableViewCell else { return UITableViewCell() }
      let medias = movieData[indexPath.row]
      
      cell.trendCellConfigure()
      cell.releaseDateLabel.text = medias.releaseDate
      cell.genreLabel.text = "#\(medias.genre)"
      cell.movieTitleLabel.text = medias.title
      cell.backdropImageView.kf.setImage(with: URL(string: medias.backdropImage), placeholder: UIImage(named: "profile_7"))
      cell.rateLabel.text = "\(medias.rate)"
      cell.starringLabel.text = medias.starring
      cell.webSiteButton.tag = indexPath.row
      cell.selectionStyle = .none
      return cell
    }
  }
}
