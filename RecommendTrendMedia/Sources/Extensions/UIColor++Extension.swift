//
//  UIColor++Extension.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/21.
//

import UIKit

extension UIColor {
  class var ramdomColor: UIColor {
    return UIColor(
      red: CGFloat.random(in: 0.7...1),
      green: CGFloat.random(in: 0.7...1),
      blue: CGFloat.random(in: 0.7...1), alpha: 1
    )
  }
}
