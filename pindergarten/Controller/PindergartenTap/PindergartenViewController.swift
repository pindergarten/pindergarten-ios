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

    lazy var getAllPindergartenDataManager: GetAllPindergartenDataManager = GetAllPindergartenDataManager()
    lazy var getPickAroundPindergartenDataManager: GetPickAroundPindergartenDataManager = GetPickAroundPindergartenDataManager()
    
    var allPindergarten: [GetAllPindergartenResult] = []
    
    var fpc: FloatingPanelController!
    var clickedMarker: NMFMarker?

    private lazy var naverMapView = NMFNaverMapView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    
    private let tapNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.text = "핀더가든"
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
    
    let contentVC = ContentViewController()
    let image = NMFOverlayImage(name: "marker")
    let selectedImage = NMFOverlayImage(name: "selectedMarker")
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        naverMapView.mapView.touchDelegate = self

        getAllPindergartenDataManager.getLikePindergarten(lat: locationManager.location?.coordinate.latitude ?? 0, lon: locationManager.location?.coordinate.longitude ?? 0, delegate: self)
        enableLocationServices()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        configureUI()

       
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
        appearance.borderColor = UIColor(hex: 0x000000, alpha: 0.15)
        appearance.borderWidth = 0

        fpc.surfaceView.appearance = appearance

        fpc.surfaceView.grabberHandleSize = .init(width: 78.0, height: 5.0)
        fpc.surfaceView.grabberHandle.backgroundColor = UIColor(hex: 0x9F9F9F)
        fpc.surfaceView.contentPadding = .init(top: 24, left: 20, bottom: 25, right: 20)


        
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.tableView)
        fpc.addPanel(toParent: self)
        fpc.layout = MyFloatingPanelLayout()
        fpc.invalidateLayout() // if needed
    }
    
    
    private func markPlace(lat: Double, lng: Double) {
        let marker = NMFMarker()
        marker.touchHandler = { [weak self] (overlay) -> Bool in
            self?.clickedMarker?.iconImage = self?.image ?? NMFOverlayImage()
            self?.clickedMarker = marker
            self?.getPickAroundPindergartenDataManager.getPickAroundPindergarten(lat: lat, lon: lng, delegate: self!)
            marker.iconImage = self!.selectedImage
            self?.scrollToPosition(lat: lat, lon: lng)
            self?.fpc.move(to: .tip, animated: false)
            // 이벤트 전파 안함
            return true
        }
    
        
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.iconImage = image
        marker.width = CGFloat(NMF_MARKER_SIZE_AUTO)
        marker.height = CGFloat(NMF_MARKER_SIZE_AUTO)
        marker.mapView = naverMapView.mapView
    }
    
    private func scrollToPosition(lat: Double, lon: Double) {
        locationManager.startUpdatingLocation()
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lon))
                    cameraUpdate.animation = .easeIn
        naverMapView.mapView.moveCamera(cameraUpdate)
    }
    
    private func configureUI() {
        view.addSubview(tapNameLabel)
        view.addSubview(heartButton)
        view.addSubview(searchButton)
        view.addSubview(naverMapView)
        
        tapNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(21)
            make.centerX.equalTo(view)
        }
        
        heartButton.snp.makeConstraints { make in
            make.centerY.equalTo(tapNameLabel)
            make.right.equalTo(searchButton.snp.left).offset(-25)
            make.width.height.equalTo(30)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(tapNameLabel)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(30)
        }
        
        naverMapView.snp.makeConstraints { make in
            make.top.equalTo(tapNameLabel.snp.bottom).offset(15)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin)
        }

    }
}

extension PindergartenViewController: NMFMapViewCameraDelegate, NMFMapViewTouchDelegate {
    
    // 카메라 위치가 변경될때마다 호출
//    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
//        print("카메라가 변경됨 : reason : \(reason)")
//        let cameraPosition = naverMapView.mapView.cameraPosition
//
//       print(cameraPosition.target.lat, cameraPosition.target.lng)
//
//    }
    
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        self.fpc.move(to: .half, animated: false)
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
            scrollToPosition(lat: locationManager.location?.coordinate.latitude ?? 0, lon: locationManager.location?.coordinate.longitude ?? 0)
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use.")
            locationManager.requestAlwaysAuthorization()
            scrollToPosition(lat: locationManager.location?.coordinate.latitude ?? 0, lon: locationManager.location?.coordinate.longitude ?? 0)
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
            scrollToPosition(lat: locationManager.location?.coordinate.latitude ?? 0, lon: locationManager.location?.coordinate.longitude ?? 0)
        } else if status == .authorizedAlways {
            scrollToPosition(lat: locationManager.location?.coordinate.latitude ?? 0, lon: locationManager.location?.coordinate.longitude ?? 0)
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("didupdateLocation")
//        if let location = locations.first {
//            print("위도: \(location.coordinate.latitude)")
//            print("경도: \(location.coordinate.longitude)")
//        }
        
//    }
}

extension PindergartenViewController {
    func didSuccessGetAllPindergarten(_ result: [GetAllPindergartenResult]) {
        allPindergarten = result
        contentVC.allPindergarten = result
        for pindergarten in result {
            markPlace(lat: Double(pindergarten.latitude ?? "0") ?? 0, lng: Double(pindergarten.longitude ?? "0") ?? 0)
        }
    }
    
    func failedToGetAllPindergarten(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessGetNearPindergarten(_ result: [GetAllPindergartenResult]) {
        allPindergarten = result
        contentVC.allPindergarten = result
    }
    
    func failedToGetNearPindergarten(message: String) {
        self.presentAlert(title: message)
    }
}

