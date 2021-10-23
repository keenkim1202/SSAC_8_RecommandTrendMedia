//
//  TheaterMapViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/21.
//

import UIKit
import MapKit

class TheaterMapViewController: UIViewController {
  
  // MARK: - UI
  @IBOutlet weak var mapView: MKMapView!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - Actions
  @IBAction func onExitButton(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func onFilterbutton(_ sender: UIBarButtonItem) {
    // TODO: 롯데시네마, CGV, 메가박스 위치 정보를 가지고 필터된 핀을 보여주도록 하기
  }
  
}
