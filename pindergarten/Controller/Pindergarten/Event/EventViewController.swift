//
//  EventViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/02.
//

import UIKit

class EventViewController: BaseViewController {
    //MARK: - Properties
    lazy var getAllEventDataManager: GetAllEventDataManager = GetAllEventDataManager()
    private var event: [GetAllEventResult] = []
    
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
        label.text = "이벤트"
        label.textColor = .mainTextColor
        return label
    }()
    
    private let seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let eventLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = UIColor(hex: 0x585858)
        label.text = "진행중인 이벤트"
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        return cv
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
            
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        
        getAllEventDataManager.getAllEvent(delegate: self)
        
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
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(seperateLine)
        view.addSubview(eventLabel)
        view.addSubview(collectionView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalTo(view)
        }
        
        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        eventLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(eventLabel.snp.bottom).offset(12)
            make.left.right.bottom.equalTo(view)
        }
    }
}


//MARK: - Extension

extension EventViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return event.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
        let index = indexPath.item
        
        cell.eventImage.kf.setImage(with: URL(string: event[index].thumbnail))
        cell.eventLabel.text = event[index].title
        cell.id = event[index].id
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailVC = DetailEventController()
        detailVC.id = event[index].id
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

extension EventViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Device.width / 2 - 25
        let height = width + 44

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// 네트워크 함수
extension EventViewController {
    func didSuccessGetAllEvent(_ result: [GetAllEventResult]) {
        print("DEBUG: GET ALL FEED")
        self.event = result
        collectionView.reloadData()
    }
    
    func failedToGetAllEvent(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED TO GET ALL FEED")
    }
}
