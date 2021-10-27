//
//  Bundle++Extension.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/27.
//

import Foundation

extension Bundle {
  var clientID: String {
    guard let file = self.path(forResource: "APIKeyInfo", ofType: "plist") else { return "" }
    
    guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
    guard let key = resource["CLIENT_ID"] as? String else { fatalError("APIKeyInfo.plist에 CLIENT_ID설정을 해주세요.")}
    return key
  }
  
  var clientSECRET: String {
    guard let file = self.path(forResource: "APIKeyInfo", ofType: "plist") else { return "" }
    
    guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
    guard let key = resource["CLIENT_SECRET"] as? String else { fatalError("APIKeyInfo.plist에 CLIENT_SECRET설정을 해주세요.")}
    return key
  }
}
