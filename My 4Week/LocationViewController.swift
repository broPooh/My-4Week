//
//  LocationViewController.swift
//  My 4Week
//
//  Created by bro on 2022/05/06.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI // ios 15에서 추가된 LocationButton을 사용하기 위함

/*
 1. 설정 유도.
 2. 위경도 -> 주소변환
 */

class LocationViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    //위치권한 가져오기
    //1. 로케이션 매니저를 활용한다
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        //지역설정
        let location = CLLocationCoordinate2D(latitude: 37.55612, longitude: 126.97236)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //핀 추가(어노테이션)
        let annotation = MKPointAnnotation()
        annotation.title = "HERE!!"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        //맵뷰에 어노테이션을 삭제하고자 할 때
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)

        mapView.delegate = self
        
        //2. Location Manager 딜리게이트 연결
        locationManager.delegate = self
    }

}

//3. location manager 딜리게이트 등록
extension LocationViewController: CLLocationManagerDelegate {
    
    //9. ios 버전에 따른 분기 처리와 ios 위치 서비스 여부 확인
    func checkUserLocationServicesAuthorization() {
        
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // ios 14이상에만 사용 가능.
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // ios 14미만에서 사용
        }
        
        
        //iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            //위치 서비스를 사용할 수 있는 상태여야지만
            //권한 상태를 확인 할 수 있다.
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요")
        }
    }
    
    //8. 사용자의 권한 상태 확인.(UDF : 사용자 정의 함수)
    // 사용자가 위치를 허용했는지 안했는지 거부한건지 이런 권한을 확인!
    // 단 ios의 위치서비스가 켜져있는지, 가능한지 확인이 먼저!
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest//정확한 위치를 얻을 때 반경을 몇으로 할지 설정하는 것. Best로 하면 자동으로 해준다.
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() //권한 획득후 위치를 업데이트하라는 함수
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() //앱을 사용하는 동안에 대한 위치 권한 요청 => didUpdateLocations 함수 실행!
        case .authorizedAlways:
            print("Always")
        @unknown default:
            print("DEFAULT")
        }
        
        if #available(iOS 14.0, *) {
            //정확도 체크 : 정확도가 감소가 되어 있는 경우. 1시간에 4번밖에 호출을 못함, 미리 알림이 동작을 안할 수 있다. 대신 배터리는 오래 쓸 수 있다. 워치8 부터 위치 페어링기능이 동작하지 않는다
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default :
                print("DEFAULT")
            }
        }
    }
    
    
    //4. 사용자가 위치 허용을 한 경우 실행
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
            
            //핀 찍쟈
            let annotaion = MKPointAnnotation()
            annotaion.title = "CURRENT LOCATION"
            annotaion.coordinate = coordinate
            mapView.addAnnotation(annotaion)
            
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
                 
            
            mapView.setRegion(region, animated: true)
            
            //10. 매우 중요!! 업데이트를 멈춰주어야한다.(자동으로 계속 되고 있다)
            //비슷한 반경에서는 업데이트를 안하도록 해주는 그런 코드는 직접 구현해주어야 한다.
            locationManager.stopUpdatingLocation()
            
        } else {
            print("Location CanNot Find")
        }
    }
    
    //5. 위치권한을 허용을 해두었지만, 어떠한 이유(비행기 모드 등)으로 위치정보를 획득하지 못하는 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    //6. ios14 미만 : 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌.
    // 권한이 변경될 때 마다 감지해서 실행. -> 이 화면에 접근하고 있을때만이지 않을까?
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    //7. ios14 이상 : 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌.
    // 권한이 변경될 때 마다 감지해서 실행.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
}


extension LocationViewController: MKMapViewDelegate {
    
    
    //맵 어노테이션 클릭시 이벤트 핸들링을 위한 함수
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Hear I am...")
    }
}
