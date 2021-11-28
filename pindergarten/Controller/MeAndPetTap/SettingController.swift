//
//  SettingController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import UIKit

class SettingController: BaseViewController {
    //MARK: - Properties
    let service = ["이용약관", "개인정보 취급방침"]
    lazy var logoutDataManager: LogoutDataManager = LogoutDataManager()
    lazy var withdrawalDataManager: WithdrawalDataManager = WithdrawalDataManager()
    
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
        label.text = "환경설정"
        label.textColor = .mainTextColor
        return label
    }()
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let versionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 버전"
        label.textColor = UIColor(hex: 0x5A5A5A)
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        return label
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "버전 정보 (V 1.0.0)"
        label.textColor = UIColor(hex: 0x5A5A5A)
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        return label
    }()
    
    private lazy var versionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [versionTitleLabel, versionLabel])
        stack.axis = .vertical
        stack.spacing = 18
        return stack
    }()
    
    private let sectionLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE9E9E9)
        return view
    }()
    
    private let serviceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 정보 및 이용 약관"
        label.textColor = UIColor(hex: 0x5A5A5A)
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        return label
    }()
    
    private lazy var termButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "이용약관", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!, .foregroundColor : UIColor(hex: 0x5A5A5A)]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapTermButton), for: .touchUpInside)
        return button
    }()
    
    private let termLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE9E9E9)
        return view
    }()
    
    private lazy var privacyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "개인정보 취급방침", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!, .foregroundColor : UIColor(hex: 0x5A5A5A)]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        return button
    }()
    
    private let privacyLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE9E9E9)
        return view
    }()
    
    private let sectionLine2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE9E9E9)
        return view
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "로그아웃", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!, .foregroundColor : UIColor(hex: 0x5A5A5A)]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        return button
    }()
    
    private let logoutLine: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .mainlineColor
        return view
    }()
    
    private lazy var withdrawalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "회원탈퇴하기", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!, .foregroundColor : UIColor(hex: 0x5A5A5A)]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapWithdrawalButton), for: .touchUpInside)
        return button
    }()
    
    private let withdrawalLine: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .mainlineColor
        return view
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Action
    
    @objc private func didTapWithdrawalButton() {
        let actionWithdrawal = UIAlertAction(title: "회원탈퇴", style: .destructive) { [weak self] action in
            self?.withdrawalDataManager.withdrawal(userId: JwtToken.userId, delegate: self!)
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "userId")
        }

        let actionCancel = UIAlertAction(title: "취소하기", style: .cancel) { action in
        }

        self.presentAlert(
            preferredStyle: .actionSheet,
            with: actionWithdrawal, actionCancel
        )
      
    }
    
    @objc private func didTapLogoutButton() {
        let actionLogout = UIAlertAction(title: "로그아웃", style: .destructive) { [weak self] action in
            self?.logoutDataManager.logout(delegate: self!)
            print(UserDefaults.standard.string(forKey: "token") ?? "")
            print(UserDefaults.standard.integer(forKey: "userId"))
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "userId")
            print(UserDefaults.standard.string(forKey: "token") ?? "")
            print(UserDefaults.standard.integer(forKey: "userId"))
        }

        let actionCancel = UIAlertAction(title: "취소하기", style: .cancel) { action in
        }

        self.presentAlert(
            preferredStyle: .actionSheet,
            with: actionLogout, actionCancel
        )
       
    }
    @objc private func didTapTermButton() {
        let termVC = ServiceTermViewController()
        termVC.titleLabel.text = "이용약관"
        termVC.termLabel.text = Constant.TERM
        navigationController?.pushViewController(termVC, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        let privacyVC = ServiceTermViewController()
        privacyVC.titleLabel.text = "개인정보 취급방침"
        privacyVC.termLabel.text = Constant.PRIVACY
        navigationController?.pushViewController(privacyVC, animated: true)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(separateLine)
        view.addSubview(versionStack)
        view.addSubview(sectionLine)
        view.addSubview(serviceTitleLabel)
        view.addSubview(termButton)
        view.addSubview(termLine)
        view.addSubview(privacyButton)
//        view.addSubview(privacyLine)
        view.addSubview(sectionLine2)
        view.addSubview(logoutButton)
        view.addSubview(logoutLine)
        view.addSubview(withdrawalButton)
        view.addSubview(withdrawalLine)
        
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton).offset(2)
            make.centerX.equalTo(view)
        }

        separateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        versionStack.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(20)
            
        }
        
        sectionLine.snp.makeConstraints { make in
            make.top.equalTo(versionStack.snp.bottom).offset(30)
            make.left.right.equalTo(view)
            make.height.equalTo(7)
        }
        
        serviceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sectionLine.snp.bottom).offset(22)
            make.left.right.equalTo(20)
        }
        
        termButton.snp.makeConstraints { make in
            make.top.equalTo(serviceTitleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        termLine.snp.makeConstraints { make in
            make.top.equalTo(termButton.snp.bottom)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(1)
        }
        
        privacyButton.snp.makeConstraints { make in
            make.top.equalTo(termLine.snp.bottom)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        sectionLine2.snp.makeConstraints { make in
            make.top.equalTo(privacyButton.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(7)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(sectionLine2.snp.bottom)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        logoutLine.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom)
            make.left.right.equalTo(view).inset(20)
        }
        
        withdrawalButton.snp.makeConstraints { make in
            make.top.equalTo(logoutLine.snp.bottom)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(60)
        }
        
        withdrawalLine.snp.makeConstraints { make in
            make.top.equalTo(withdrawalButton.snp.bottom)
            make.left.right.equalTo(view).inset(20)
//            make.bottom.lessThanOrEqualTo(containerView).offset(-40)
        }

    }
}

//MARK: - Extension

// 네트워크 함수
extension SettingController {
    func didSuccessLogout() {
        self.presentAlert(title: "로그아웃에 성공하였습니다.") {[weak self] _ in
            self?.changeRootViewController(UINavigationController(rootViewController: NewSplashController()))
        }
       
    }
    
    func failedToLogout(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessWithdrawal() {
        self.presentAlert(title: "회원 탈퇴에 성공하였습니다.") {[weak self] _ in
            self?.changeRootViewController(UINavigationController(rootViewController: NewSplashController()))
        }
    }
    
    func failedToWithdrawal(message: String) {
        self.presentAlert(title: message)
    }
}
