//
//  WebLinkViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/21.
//

import UIKit
import WebKit

class WebLinkViewController: UIViewController {
  
  // MARK: Properties
  var navigationTitle: String = "제목"
  
  // MARK: UI
  @IBOutlet weak var webView: WKWebView!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = navigationTitle
  }
}
