//
//  ContentViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/12.
//

import UIKit
import CoreLocation

class ContentViewController: BaseViewController {
    
    //MARK: - Properties
    private lazy var locationManager = CLLocationManager()
    
    lazy var getAllPindergartenDataManager: GetAllPindergartenDataManager = GetAllPindergartenDataManager()
    lazy var pindergartenLikeDataManager: PindergartenLikeDataManager = PindergartenLikeDataManager()
    lazy var getPickAroundPindergartenDataManager: GetPickAroundPindergartenDataManager = GetPickAroundPindergartenDataManager()
    
    var allPindergarten: [GetAllPindergartenResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getAllPindergartenDataManager.getLikePindergarten(lat: locationManager.location?.coordinate.latitude ?? Constant.DEFAULT_LAT, lon: locationManager.location?.coordinate.longitude ?? Constant.DEFAULT_LON, delegate: self)
        
        locationManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PindergartenCell.self, forCellReuseIdentifier: PindergartenCell.identifier)
        configureUI()
        
//        print(locationManager.location?.coordinate.latitude)
//        print(locationManager.location?.coordinate.longitude)
    }
    
    //MARK: - Action
    
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}


//MARK: - Extension
extension ContentViewController: PindergartenCellDelegate {
    func didTapCellHeartButton(id: Int, index: Int) {
        print(id, index)
        pindergartenLikeDataManager.likePindergarten(pindergartenId: id, delegate: self)
//        if allPindergarten[index].isLiked == 0 {
//            allPindergarten[index].isLiked = 1
//        } else {
//            allPindergarten[index].isLiked = 0
//        }
    }
    
    
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allPindergarten.count > 10 {
            return 10
        }
        return allPindergarten.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PindergartenCell.identifier, for: indexPath) as! PindergartenCell
        cell.delegate = self
        cell.selectionStyle = .none
        
        cell.pindergartenImage.kf.setImage(with: URL(string: allPindergarten[indexPath.item].thumbnail))
        cell.nameLabel.text = allPindergarten[indexPath.item].name
        cell.addressLabel.text = allPindergarten[indexPath.item].address
        cell.distanceLabel.text = "\(String(format: "%.1f", allPindergarten[indexPath.item].distance ?? 0))km"
    
        if allPindergarten[indexPath.item].isLiked == 1 {
            cell.heartButton.setImage(UIImage(named: "pcellFilledHeart"), for: .normal)
        } else {
            cell.heartButton.setImage(UIImage(named: "pcellHeart"), for: .normal)
        }
        
        cell.scoreLabel.text = "\(String(format: "%.2f", allPindergarten[indexPath.item].rating))/5"
        cell.starView.rating = allPindergarten[indexPath.item].rating
        cell.heartButton.tag = allPindergarten[indexPath.item].id
        cell.index = indexPath.item
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailPindergartenController()
        detailVC.pindergartenID = allPindergarten[indexPath.item].id
        navigationController?.pushViewController(detailVC, animated: true)
        print(indexPath.item)
    }
}

//MARK: - Extension
extension ContentViewController: CLLocationManagerDelegate {
    private func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("DEBUG: Not determined.")
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("DEBUG: Auth always.")
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use.")
        @unknown default:
            break
        }
    }
}

// 네트워크 함수
extension ContentViewController {
    func didSuccessGetAllPindergarten(_ result: [GetAllPindergartenResult]) {
        allPindergarten = result
    }
    
    func failedToGetAllPindergarten(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessLikePindergarten(_ result: PindergartenLikeResult) {
        print(result.isSet)
        
    }
    
    func failedToLikePindergarten(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessGetNearPindergarten(_ result: [GetAllPindergartenResult]) {
        allPindergarten = result
    }
    
    func failedToGetNearPindergarten(message: String) {
        self.presentAlert(title: message)
    }
}


