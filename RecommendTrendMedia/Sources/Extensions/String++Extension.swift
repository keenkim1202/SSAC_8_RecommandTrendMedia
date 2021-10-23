//
//  String++Extension.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/23.
//

import Foundation

extension String {
  func replaceTargetsToReplacement(_ occurs: [String], _ replacement: String) -> String {
    var converted = self
    for occur in occurs {
      converted = converted.replacingOccurrences(of: occur, with: replacement)
    }
    return converted
  }
}
