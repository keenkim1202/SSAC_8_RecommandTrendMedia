//
//  APIService.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/26.
//

import Foundation
import Alamofire
import SwiftyJSON
import AVFoundation

// MARK: fetchTrendData에서 pagination 구현

class APIService {
  // MARK: Enum - MediaType & TimeWindow
  enum MediaType: String {
    case all
    case movie
    case tv
    case person
  }
  
  enum TimeWindow: String {
    case day
    case week
  }
  
  // MARK: Properties
  static let shared = APIService()
  typealias CompletionHandler = (Int, JSON) -> ()
  
  let endPointURL = "https://api.themoviedb.org/3"
  let apikey = Bundle.main.TMDBapikey
  let param = ["api_key": Bundle.main.TMDBapikey]
  
  // MARK: FetchData
  // 영화 검색 데이터
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
  
  // 트렌드 미디어 데이터
  func fetchTrendData(mediaType: MediaType, timeWindow: TimeWindow, result: @escaping CompletionHandler) {
    let url = "\(endPointURL)/trending/\(mediaType)/\(timeWindow)"
    
    AF.request(url, method: .get, parameters: param).validate(statusCode: 200...500).responseJSON { response in
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
  
  // 장르 데이터
  func fetchGenreData(result: @escaping CompletionHandler) {
    let url = "\(endPointURL)/genre/list"
    
    AF.request(url, method: .get, parameters: param).validate(statusCode: 200...500).responseJSON { response in
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
  
  // 출연진 데이터
  func fetchCreditData(mediaID: Int, mediaType: MediaType, result: @escaping CompletionHandler) {
    let url = "\(endPointURL)/\(mediaType)/\(mediaID)/credits"
    
    AF.request(url, method: .get, parameters: param).validate(statusCode: 200...500).responseJSON { response in
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
  
  // 트레일러 데이터
  func fetchMediaTrailer(mediaID: Int, mediaType: MediaType, result: @escaping CompletionHandler) {
    let url = "\(endPointURL)/\(mediaType)/\(mediaID)/videos"
    
    AF.request(url, method: .get, parameters: param).validate(statusCode: 200...500).responseJSON { response in
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
