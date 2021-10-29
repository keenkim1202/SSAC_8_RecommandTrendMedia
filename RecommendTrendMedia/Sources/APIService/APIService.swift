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

class APIService {
  
  static let shared = APIService()
  typealias CompletionHandler = (Int, JSON) -> ()
  
  func fetchMovieData(_ query: String, result: @escaping CompletionHandler) {
    
    if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
      
      let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
      let header: HTTPHeaders = [
        "X-Naver-Client-Id": Bundle.main.clientID,
        "X-Naver-Client-Secret": Bundle.main.clientSECRET
      ]
      
      AF.request(url, method: .get, headers: header).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
          let json = JSON(value)
          let code = response.response?.statusCode ?? 500
          
          result(code, json)
          
        case .failure(let error):
          print(error)
        }
        

      }
    }
  }
}
