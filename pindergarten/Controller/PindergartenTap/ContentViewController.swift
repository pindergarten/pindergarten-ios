//
//  ContentViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/12.
//

import UIKit
import CoreLocation

class ContentViewController: BaseViewController {
    deinit {
            print("deinit")
    }
    
    //MARK: - Properties
//    private lazy var locationManager = CLLocationManager()
    
//    lazy var getAllPindergartenDataManager: GetAllPindergartenDataManager = GetAllPindergartenDataManager()
    lazy var pindergartenLikeDataManager: PindergartenLikeDataManager = PindergartenLikeDataManager()
//    lazy var getPickAroundPindergartenDataManager: GetPickAroundPindergartenDataManager = GetPickAroundPindergartenDataManager()
    
    var contentPindergarten: [GetAllPindergartenResult] = [] {
        didSet {
            print("contentPindergarten reload")
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
        
//        locationManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PindergartenCell.self, forCellReuseIdentifier: PindergartenCell.identifier)
        configureUI()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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

        pindergartenLikeDataManager.likePindergarten(pindergartenId: id,index: index, delegate: self)
        
        
    }
    
    
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contentPindergarten.count > 10 {
            return 10
        }
        return contentPindergarten.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PindergartenCell.identifier, for: indexPath) as! PindergartenCell
        cell.delegate = self
        cell.selectionStyle = .none
        
        cell.pindergartenImage.kf.setImage(with: URL(string: contentPindergarten[indexPath.item].thumbnail))
        cell.nameLabel.text = contentPindergarten[indexPath.item].name
        cell.addressLabel.text = contentPindergarten[indexPath.item].address
        cell.distanceLabel.text = "\(String(format: "%.1f", contentPindergarten[indexPath.item].distance ?? 0))km"
    
        if contentPindergarten[indexPath.item].isLiked == 1 {
            cell.heartButton.setImage(UIImage(named: "pcellFilledHeart"), for: .normal)
        } else {
            cell.heartButton.setImage(UIImage(named: "pcellHeart"), for: .normal)
        }
        
        cell.scoreLabel.text = "\(Int(contentPindergarten[indexPath.item].rating))/5"
        cell.starView.rating = contentPindergarten[indexPath.item].rating
        cell.heartButton.tag = contentPindergarten[indexPath.item].id
        cell.index = indexPath.item
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailPindergartenController()
        detailVC.pindergartenID = contentPindergarten[indexPath.item].id
        navigationController?.pushViewController(detailVC, animated: true)
        print(indexPath.item)
    }
}

//MARK: - Extension
extension ContentViewController: CLLocationManagerDelegate {
//    private func enableLocationServices() {
//        locationManager.delegate = self
//
//        switch CLLocationManager.authorizationStatus() {
//        case .notDetermined:
//            print("DEBUG: Not determined.")
//        case .restricted, .denied:
//            break
//        case .authorizedAlways:
//            print("DEBUG: Auth always.")
//        case .authorizedWhenInUse:
//            print("DEBUG: Auth when in use.")
//        @unknown default:
//            break
//        }
//    }
}

// 네트워크 함수
extension ContentViewController {
//    func didSuccessGetAllPindergarten(_ result: [GetAllPindergartenResult]) {
//        allPindergarten = result
//    }
//
//    func failedToGetAllPindergarten(message: String) {
//        self.presentAlert(title: message)
//    }
    
    func didSuccessLikePindergarten(id: Int, idx: Int, _ result: PindergartenLikeResult) {
        
        contentPindergarten[idx].isLiked = result.isSet
         
    }
    
    func failedToLikePindergarten(message: String) {
        self.presentAlert(title: message)
    }
    
//    func didSuccessGetNearPindergarten(_ result: [GetAllPindergartenResult]) {
//        allPindergarten = result
//    }
//
//    func failedToGetNearPindergarten(message: String) {
//        self.presentAlert(title: message)
//    }
}


