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
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        return label
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "버전 정보(V 0.0.0)"
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
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
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
    @objc private func didTapPrivacyButton() {
        
    }
    
    @objc private func didTapTermButton() {
        
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
        view.addSubview(privacyLine)
        
        
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
            make.top.equalTo(separateLine.snp.bottom).offset(18)
            make.left.right.equalTo(view).inset(20)
            
        }
        
        sectionLine.snp.makeConstraints { make in
            make.top.equalTo(versionStack.snp.bottom).offset(30)
            make.left.right.equalTo(view)
            make.height.equalTo(7)
        }
        
        serviceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sectionLine.snp.bottom).offset(30)
            make.left.right.equalTo(20)
        }
        
        termButton.snp.makeConstraints { make in
            make.top.equalTo(serviceTitleLabel.snp.bottom).offset(10)
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
        
        privacyLine.snp.makeConstraints { make in
            make.top.equalTo(privacyButton.snp.bottom)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(1)
        }

    }
}

//MARK: - Extension

