//
//  SignUpPasswordViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/28.
//

import UIKit

class SignUpPasswordViewController: BaseViewController {
    //MARK: - Properties
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.setDimensions(height: 30, width: 30)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private let progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.progressTintColor = .mainBrown
        progressBar.trackTintColor = UIColor(hex: 0xE0E0E0)
        progressBar.progress = 2/3
        return progressBar
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 59, height: 26))
        label.text = "기본 정보"
        label.textColor = .mainTextColor
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        return label
    }()
    
    private let passwordStack = CustomInputView(title: "비밀번호", placeholder: "8~16자 이내의 비밀번호", isSecure: true)
    
    private let checkPasswordStack = CustomInputView(title: "비밀번호 확인", placeholder: "8~16자 이내의 비밀번호", isSecure: true)
    
    private let correctPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "*비밀번호가 일치하지 않습니다."
        label.textColor = .mainBrown
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .white
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.mainLightYellow.cgColor
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    //MARK: - Action
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Helpers
    private func configureUI() {

        view.addSubview(backButton)
        view.addSubview(progressBar)
        view.addSubview(infoLabel)
        view.addSubview(passwordStack)
        view.addSubview(checkPasswordStack)
        view.addSubview(correctPasswordLabel)
        view.addSubview(nextButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(62)
            make.left.equalTo(view).offset(8)
        }
        progressBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).offset(27)
            make.height.equalTo(3)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(24)
            make.left.equalTo(view).offset(20)
        }
        passwordStack.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(24)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        checkPasswordStack.snp.makeConstraints { make in
            make.top.equalTo(passwordStack.snp.bottom).offset(26)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        correctPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(checkPasswordStack.snp.bottom).offset(8)
            make.left.equalTo(view).offset(20)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-74)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
    }
}
