//
//  APIService.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/26.
//

import Foundation
import Alamofire
import SwiftyJSON
 
// TODO: query 입력받게 수정하기
// TODO: image kf로 띄워주기

struct APIService {
  
  // searchVC : 네이버 영화 네트워크 통신
  func fetchMovieData() -> [TvShow] {
    var datas: [TvShow] = []
    
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
//          print("JSON: \(json)")
          
          let items = json["items"].arrayValue
          
          for item in items {
            let media = TvShow(
              title: item["title"].stringValue,
              releaseDate: item["pubDate"].stringValue,
              genre: "장르",
              region: "지역",
              overview: "줄거리",
              rate: item["userRating"].doubleValue,
              starring: item["actor"].stringValue,
              backdropImage: item["image"].stringValue)
            datas.append(media)
          }
          
//          print("DATAS: ", datas)
          
        case .failure(let error):
          print(error)
        }
      }
    }
    return datas
  }
}
