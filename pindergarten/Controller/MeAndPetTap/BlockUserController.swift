//
//  BlockUserController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/13.
//

import UIKit

protocol UnblockUserDelegate: AnyObject {
    func didTapUnblockButton(userId: Int)
}

class BlockedUserCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "BlockedUserCell"
    var userId: Int = 0
    
    weak var delegate: UnblockUserDelegate?
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 17
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        label.textColor = UIColor(hex: 0x2D2D2D, alpha: 0.85)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        label.textColor = UIColor(hex: 0xA1A1A1)
        return label
    }()
    
    lazy var unblockButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = .mainTextColor
        button.setAttributedTitle(NSMutableAttributedString(string: "차단 해제", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 12)!]), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.mainlineColor.cgColor
        button.addTarget(self, action: #selector(didTapUnblockButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Action
    @objc private func didTapUnblockButton() {
        delegate?.didTapUnblockButton(userId: userId)
    }
    //MARK: - Helpers
    private func configureUI() {
        backgroundColor = .white
        
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(unblockButton)
        
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage)
            make.left.equalTo(profileImage.snp.right).offset(8)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(timeLabel.snp.top).offset(-4)
        }

        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(contentView).offset(-20)
        }
        
        unblockButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.bottom.equalTo(timeLabel.snp.bottom)
            make.right.equalTo(contentView).inset(20)
            make.width.equalTo(80)
        }
    }
}

class BlockUserController: BaseViewController {
    //MARK: - Properties
    lazy var getBlockUserDataManager: GetBlockUserDataManager = GetBlockUserDataManager()
    lazy var unblockUserDataManager: UnblockUserDataManager = UnblockUserDataManager()
    
    var blockedUsers = [GetBlockUserResult]() {
        didSet {
            blockedUserTableView.reloadData()
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
        label.text = "차단된 계정"
        label.textColor = .mainTextColor
        return label
    }()
    
    private let seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let blockedUserTableView: UITableView = {
       let tv = UITableView()
        tv.bounces = false
        tv.backgroundColor = .white
        tv.separatorStyle = .singleLine
        tv.separatorColor = UIColor(hex: 0xF3F4F6)
        tv.tableFooterView = UIView()
        return tv
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBlockUserDataManager.getBlockUser(delegate: self)
        configureUI()
        setUpTableView()
    }
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    private func setUpTableView() {
        blockedUserTableView.delegate = self
        blockedUserTableView.dataSource = self
        blockedUserTableView.register(BlockedUserCell.self, forCellReuseIdentifier: BlockedUserCell.identifier)
    }
    
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(seperateLine)
        view.addSubview(blockedUserTableView)
        
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
        
        blockedUserTableView.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
}

//MARK: - Extension
extension BlockUserController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BlockedUserCell.identifier, for: indexPath) as! BlockedUserCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.userId = blockedUsers[indexPath.item].blockUserId
        cell.profileImage.kf.setImage(with: URL(string: blockedUsers[indexPath.item].profileimg))
        cell.nameLabel.text = blockedUsers[indexPath.item].nickname
        cell.timeLabel.text = blockedUsers[indexPath.item].date
        
        return cell
    }
}

extension BlockUserController: UnblockUserDelegate {
    func didTapUnblockButton(userId: Int) {
        let blockAction = UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            self?.unblockUserDataManager.unblockUser(userId: userId, delegate: self!)
        }
    
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        
        self.presentAlert(title: "차단 해제하시겠습니까?", with: blockAction, cancelAction)
    }
}

// 네트워크 함수
extension BlockUserController {
    
    func didSuccessGetBlockUser(_ result: [GetBlockUserResult]) {
        blockedUsers = result
    }
    
    func failedToGetBlockUser(message: String) {
        self.presentAlert(title: message) { [weak self] _ in 
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func didSuccessUnblockUser() {
        self.presentAlert(title: "차단 해제되었습니다.") { [weak self] _ in
            self?.getBlockUserDataManager.getBlockUser(delegate: self!)
        }
    }
    
    func failedToUnblockUser(message: String) {
        self.presentAlert(title: message) 
    }
}
