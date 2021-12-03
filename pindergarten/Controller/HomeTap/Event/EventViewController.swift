//
//  EventViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/02.
//

import UIKit

class AllEventHeaderView: UICollectionReusableView {

    //MARK: - Properties
    static let identifier = "AllEventHeaderView"
    
    let eventLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = UIColor(hex: 0x585858)
        label.text = "진행중인 이벤트"
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(eventLabel)
        
        eventLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class EventViewController: BaseViewController {
    //MARK: - Properties
    lazy var getAllEventDataManager: GetAllEventDataManager = GetAllEventDataManager()
    private var event: [GetAllEventResult] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
    
   
    
    var daysCount:Int = 0

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
            
        getAllEventDataManager.getAllEvent(delegate: self)
        
       
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        collectionView.register(AllEventHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AllEventHeaderView.identifier)
        

        
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
    
    
    
    func days(to date: String) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let current = dateFormatter.string(from: currentDate)
        let startDate = dateFormatter.date(from: current)!
        let expireDay = dateFormatter.date(from: date)!
        return calendar.dateComponents([.day], from: startDate, to: expireDay).day!

    }
    
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(seperateLine)
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
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom)
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
        
        cell.eventImage.kf.indicatorType = .activity
        cell.eventImage.kf.setImage(with: URL(string: event[index].thumbnail), placeholder: nil, options: [.transition(.fade(0.7)), .loadDiskFileSynchronously], progressBlock: nil)
        cell.eventLabel.text = event[index].title
        cell.id = event[index].id
        if days(to: event[index].expiredAt) == 0 {
            cell.dDayLabel.text = "D-DAY"
        } else {
            cell.dDayLabel.text = "D-\(days(to: event[index].expiredAt))"
        }
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailVC = DetailEventController()
        detailVC.id = event[index].id
        detailVC.dday = days(to: event[index].expiredAt)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AllEventHeaderView.identifier, for: indexPath) as! AllEventHeaderView
            
             return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 54)
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
        self.event = result

    }
    
    func failedToGetAllEvent(message: String) {
        self.presentAlert(title: message)
    }
}
