//
//  LikePindergartenController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/13.
//

import UIKit

class LikePindergartenController: BaseViewController {
    //MARK: - Properties
    lazy var getLikePindergartenDataManager: GetLikePindergartenDataManager = GetLikePindergartenDataManager()
    
    var likeResult: [GetLikePindergartenResult]?
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
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
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
        
        getLikePindergartenDataManager.getLikePindergarten(delegate: self)
        
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
    
    @objc private func didTapHeartButton() {
        print("DEBUG: TAPPED HEART BUTTON")
    }
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
    func didTapCellHeartButton(index: Int) {
        print("DEBUG: TAPPED HEART BUTTON")
    }
}
extension LikePindergartenController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PindergartenCell.identifier, for: indexPath) as! PindergartenCell
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("왜 하트버튼이 안눌러지지")
    }
    
}

// 네트워크 함수
extension LikePindergartenController {
    func didSuccessGetLikePindergarten(_ result: GetLikePindergartenResult) {
        
    }
    
    func failedToGetAllPindergarten(message: String) {
        self.presentAlert(title: message)
    }
}
