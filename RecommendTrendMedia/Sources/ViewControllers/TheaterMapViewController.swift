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

// TODO: 위치 접근 권한 설정 -> 권한 확인하는 얼럿 떠야하는데 안뜨네 다시.
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
    
    /// 지도 조건 설정하기
    let location = CLLocationCoordinate2D.init(latitude: 37.556124592490924, longitude: 126.97235991352282)
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: location, span: span)
    mapView.setRegion(region, animated: true)
    
    addAnnortations(theatherInfo.mapAnnotations)
    
    mapView.delegate = self
    locationManager.delegate = self
  }
  
  func addAnnortations(_ items: [TheaterLocation]) {
    
    for item in items {
      let annortation = MKPointAnnotation()
      annortation.title = item.location
      annortation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
      mapView.addAnnotation(annortation)
    }

//    let annotations = mapView.annotations
//    mapView.removeAnnotations(annotations)
  }
  
  // MARK: - Actions
  @IBAction func onExitButton(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func onFilterbutton(_ sender: UIBarButtonItem) {
    
  }
  
}

// MARK: Extension
// MARK: - CLLocationManagerDelegate
extension TheaterMapViewController: CLLocationManagerDelegate {
  /// iOS 버전에 따른 분기처리와 iOS 위치 서비스 여부 확인
  func checkUserLocationServicesAuthriozaton() {
    
    let authorizationStatus: CLAuthorizationStatus
    
    if #available(iOS 14.0, *) {
      authorizationStatus = locationManager.authorizationStatus // iOS14 이상
    } else {
      authorizationStatus = CLLocationManager.authorizationStatus() // iOS14 미만
    }
    
    /// iOS 위치 서비스 확인
    if CLLocationManager.locationServicesEnabled() {
      checkCurrentLocationAuthorization(authorizationStatus)
    } else {
      print("error - 위치 서비스를 확인해주세요")
    }
    
    /// 사용자의 권한 상태 확인
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
      switch authorizationStatus {
        // TODO: 권한에 따라 분기하기 - alert 창 띄우기
      case .notDetermined:
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치에 대한 정확도를 개발자가 직접 지정
        locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
        locationManager.startUpdatingLocation() // 위치 접근 시작
      case .restricted, .denied:
        print("DENIED, 설정으로 유도")
      case .authorizedWhenInUse:
        locationManager.startUpdatingLocation() // 위치 접근 시작
      case .authorizedAlways:
        print("ALWAYS")
      @unknown default:
        print("DEFUALT")
      }
    }
  }
  
  ///사용자가 위치를 허용한 경우
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print(locations)
    
    if let coordinate = locations.last?.coordinate {
      let annotation = MKPointAnnotation()
      annotation.title = "현재 위치" // TEST
      annotation.coordinate = coordinate
      mapView.addAnnotation(annotation)
      
      let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      let region = MKCoordinateRegion(center: coordinate, span: span)
      mapView.setRegion(region, animated: true)
      
      locationManager.stopUpdatingLocation()
      
    } else {
      print("Location Cannot Find.")
    }
  }
  
  /// iOS14 미만 설정
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    checkUserLocationServicesAuthriozaton()
  }
  
  /// iOS14 이상 설정
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkUserLocationServicesAuthriozaton()
  }
}

// MARK: - MKMapViewDelegate
extension TheaterMapViewController: MKMapViewDelegate {
  /// 탭 어노테이션 클릭 시 이벤트 핸들링
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    print("im here!!") // TEST
  }
}
