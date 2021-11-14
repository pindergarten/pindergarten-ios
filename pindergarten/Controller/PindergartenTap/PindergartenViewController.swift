//
//  SearchViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/31.
//

import UIKit
import CoreLocation
import NMapsMap
import FloatingPanel

class MyFloatingPanelLayout: FloatingPanelLayout {

    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .half
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] { // 가능한 floating panel: 현재 full, half만 가능하게 설정
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 56.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 32.0, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 245.0, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}

class PindergartenViewController: BaseViewController, FloatingPanelControllerDelegate {
    //MARK: - Properties
    
    private lazy var locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D!
    
    var fpc: FloatingPanelController!
    
    private lazy var NMapView = NMFMapView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    private lazy var naverMapView = NMFNaverMapView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    
    private let tapNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.text = "펫 유치원"
        label.textColor = .mainTextColor
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pindergartenHeart"), for: .normal)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pindergartenSearch"), for: .normal)
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableLocationServices()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        configureUI()
        markPlace()
        setFloatingPanel()
        
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_TRANSIT, isEnabled: true)
        naverMapView.mapView.isIndoorMapEnabled = true
        naverMapView.mapView.locationOverlay.hidden = false
        naverMapView.mapView.positionMode = .compass
        
        naverMapView.showLocationButton = true
        naverMapView.showCompass = false
        naverMapView.showScaleBar = false
        naverMapView.mapView.logoAlign = .leftTop
        naverMapView.mapView.addCameraDelegate(delegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
    }
    //MARK: - Action
    @objc private func didTapHeartButton() {
        let likePindergartenVC = LikePindergartenController()
        navigationController?.pushViewController(likePindergartenVC, animated: true)
    }
    
    @objc private func didTapSearchButton() {
        let searchPindergartenVC = SearchPindergartenController()
        navigationController?.pushViewController(searchPindergartenVC, animated: true)
    }
    //MARK: - Helpers
    private func setFloatingPanel() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()

        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: -4.0)
        shadow.opacity = 0.15
        shadow.radius = 12
        appearance.shadows = [shadow]
        
        appearance.cornerRadius = 20.0
        appearance.backgroundColor = .white
        appearance.borderColor = .clear
        appearance.borderWidth = 0

        fpc.surfaceView.appearance = appearance

        fpc.surfaceView.grabberHandleSize = .init(width: 78.0, height: 5.0)
        fpc.surfaceView.grabberHandle.backgroundColor = UIColor(hex: 0x9F9F9F)
        fpc.surfaceView.contentPadding = .init(top: 24, left: 20, bottom: 25, right: 20)


        let contentVC = ContentViewController()
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.tableView)
        fpc.addPanel(toParent: self)
        fpc.layout = MyFloatingPanelLayout()
        fpc.invalidateLayout() // if needed
    }
    
    
    private func markPlace() {
        let marker = NMFMarker()
        marker.touchHandler = { (overlay) -> Bool in
            print("마커 1 터치됨")
            self.fpc.move(to: .tip, animated: false)
            // 이벤트 전파 안함
            return true
        }
        
        marker.position = NMGLatLng(lat: 35.178928121244816, lng: 129.05542242185882)
        marker.iconImage = NMFOverlayImage(name: "marker")
        marker.width = CGFloat(NMF_MARKER_SIZE_AUTO)
        marker.height = CGFloat(NMF_MARKER_SIZE_AUTO)
        marker.mapView = naverMapView.mapView
    }
    
    private func scrollToPosition() {
        locationManager.startUpdatingLocation()
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
                    cameraUpdate.animation = .easeIn
        naverMapView.mapView.moveCamera(cameraUpdate)
    }
    
    private func configureUI() {
        view.addSubview(tapNameLabel)
        view.addSubview(heartButton)
        view.addSubview(searchButton)
        view.addSubview(naverMapView)
        
        tapNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(18)
            make.centerX.equalTo(view)
        }
        
        heartButton.snp.makeConstraints { make in
            make.centerY.equalTo(tapNameLabel)
            make.right.equalTo(searchButton.snp.left).offset(-25)
            make.width.height.equalTo(25)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(tapNameLabel)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(25)
        }
        
        naverMapView.snp.makeConstraints { make in
            make.top.equalTo(tapNameLabel.snp.bottom).offset(18)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin)
        }

    }
}

extension PindergartenViewController: NMFMapViewCameraDelegate, NMFMapViewTouchDelegate {
    // 카메라 위치가 변경될때마다 호출
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        print("카메라가 변경됨 : reason : \(reason)")
        let cameraPosition = naverMapView.mapView.cameraPosition
       
       print(cameraPosition.target.lat, cameraPosition.target.lng)

    }
    
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("지도 터치됨")
    }
}




extension PindergartenViewController: CLLocationManagerDelegate {
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("DEBUG: Not determined.")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("DEBUG: Auth always.")
            scrollToPosition()
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use.")
            locationManager.requestAlwaysAuthorization()
            scrollToPosition()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
            scrollToPosition()
        } else if status == .authorizedAlways {
            scrollToPosition()
        }
    }
}
