//
//  LikePindergartenController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/13.
//

import UIKit
import CoreLocation
import Kingfisher

class LikePindergartenController: BaseViewController {
    deinit {
            print("deinit")
    }
    //MARK: - Properties
    lazy var getLikePindergartenDataManager: GetLikePindergartenDataManager = GetLikePindergartenDataManager()
    lazy var pindergartenLikeDataManager: PindergartenLikeDataManager = PindergartenLikeDataManager()
    
    var likeResult: [GetLikePindergartenResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var locationManager = CLLocationManager()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.text = "좋아요 한 유치원"
        label.textColor = .mainTextColor
        return label
    }()

    private lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pindergartenFilledHeart"), for: .normal)
//        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    private let seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
        return tableView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLikePindergartenDataManager.getLikePindergarten(lat: locationManager.location?.coordinate.latitude ?? Constant.DEFAULT_LAT, lon: locationManager.location?.coordinate.longitude ?? Constant.DEFAULT_LON, delegate: self)

        setUpTableView()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
//    @objc private func didTapHeartButton() {
//        print("DEBUG: TAPPED HEART BUTTON")
//    }
    //MARK: - Helpers
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PindergartenCell.self, forCellReuseIdentifier: PindergartenCell.identifier)
    }
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(heartButton)
        view.addSubview(seperateLine)
        view.addSubview(tableView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalTo(view)
        }

        
        heartButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(25)
        }
        
        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom)
            make.left.right.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - Extension
extension LikePindergartenController: PindergartenCellDelegate {
    func didTapCellHeartButton(id: Int) {
        print("DEBUG: TAPPED HEART BUTTON")
        pindergartenLikeDataManager.likePindergarten(pindergartenId: id, delegate: self)
        
    }
}
extension LikePindergartenController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeResult.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PindergartenCell.identifier, for: indexPath) as! PindergartenCell
        cell.delegate = self
        cell.selectionStyle = .none
        
        cell.pindergartenImage.kf.setImage(with: URL(string: likeResult[indexPath.item].thumbnail))
        cell.distanceLabel.text = "\(String(format: "%.1f", likeResult[indexPath.item].distance))km"
        cell.nameLabel.text = likeResult[indexPath.item].name
        cell.addressLabel.text = likeResult[indexPath.item].address
        cell.scoreLabel.text = "\(Int(likeResult[indexPath.item].rating))/5"
        cell.starView.rating = Double(likeResult[indexPath.item].rating)
        
        cell.heartButton.setImage(UIImage(named: "pcellFilledHeart"), for: .normal)
        cell.heartButton.tag = likeResult[indexPath.item].id
        cell.index = indexPath.item
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailPindergartenController()
        detailVC.pindergartenID = likeResult[indexPath.item].id

        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

// 네트워크 함수
extension LikePindergartenController {
    func didSuccessGetLikePindergarten(_ result: [GetLikePindergartenResult]) {
        likeResult = result
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
}
