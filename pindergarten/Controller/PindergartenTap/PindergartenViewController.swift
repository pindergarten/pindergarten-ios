//
//  SearchViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/31.
//

import UIKit
import CoreLocation

class PindergartenViewController: BaseViewController {
    //MARK: - Properties
    
    var locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D!
    
    private let tapNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.text = "펫 유치원"
        label.textColor = .mainTextColor
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pindergartenHeart"), for: .normal)
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pindergartenSearch"), for: .normal)
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        configureUI()
    }
    
    //MARK: - Action
    
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(tapNameLabel)
        view.addSubview(heartButton)
        view.addSubview(searchButton)
        
        tapNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(24)
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
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use.")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}
