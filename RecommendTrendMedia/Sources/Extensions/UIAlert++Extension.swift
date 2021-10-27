//
//  UIAlert++Extension.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/23.
//

import UIKit

// 위치 권한이 없을 경우애는 설정창으로 이동하도록 하기
// 영화관 브랜드별 분기용으로 pageSheet? 만들기
extension UIAlertController {
  enum ContentType: String {
    case needAuthorization = "⚠️ 위치 권한 없음 🤯"
    case cannotFindLocation = "🤔 위치를 찾을 수 없습니다."
  }
  
  static func show(_ presentedHost: UIViewController,
                   contentType: ContentType,
                   message: String) {
    let alert = UIAlertController(
      title: contentType.rawValue,
      message: message,
      preferredStyle: .alert)
    let okAction = UIAlertAction(
      title: "확인", style: .default, handler: nil)
    alert.addAction(okAction)
    presentedHost.present(alert, animated: true, completion: nil)
  }
}
