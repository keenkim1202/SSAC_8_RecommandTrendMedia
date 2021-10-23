//
//  TheaterMapViewController.swift
//  RecommendTrendMedia
//
//  Created by KEEN on 2021/10/21.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI

// TODO: 위치 접근 권한 설정
// TODO: 상영관 위치정보 핀 찍기
// TODO: 롯데시네마, CGV, 메가박스 위치 정보를 가지고 필터된 핀을 보여주도록 하기

class TheaterMapViewController: UIViewController {
  
  // MARK: - Properties
  let theatherInfo = TheaterInfo()
  let locationManager = CLLocationManager()
  
  // MARK: - UI
  @IBOutlet weak var mapView: MKMapView!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self
  }
  
  // MARK: - Actions
  @IBAction func onExitButton(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func onFilterbutton(_ sender: UIBarButtonItem) {
    
  }
  
}

// MARK: Extension - CLLocationManagerDelegate
extension TheaterMapViewController: CLLocationManagerDelegate {
  
}
