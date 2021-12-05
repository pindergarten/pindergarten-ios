//
//  ResetPasswordViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import UIKit

class ResetPasswordViewController: BaseViewController {

    //MARK: - Properties
    lazy var resetDataManager: ResetPasswordDataManager = ResetPasswordDataManager()
    
    var phoneNumber: String = ""
    
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
        progressBar.progress = 0
        return progressBar
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 59, height: 26))
        label.text = "비밀번호 재설정"
        label.textColor = .mainTextColor
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        return label
    }()
    
    private let passwordStack = CustomInputView(title: "새 비밀번호", placeholder: "8~16자 이내의 비밀번호", isSecure: true)
    
    private let checkPasswordStack = CustomInputView(title: "새 비밀번호 확인", placeholder: "8~16자 이내의 비밀번호", isSecure: true)
    
    private let correctPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "*비밀번호가 일치하지 않습니다."
        label.textColor = .mainBrown
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        label.isHidden = true
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSMutableAttributedString(string: "다음", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!]), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.mainLightYellow.cgColor
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboardWhenTappedAround()
        passwordStack.textField.becomeFirstResponder()
        
        passwordStack.textField.returnKeyType = .continue
        checkPasswordStack.textField.returnKeyType = .done
        passwordStack.textField.delegate = self
        checkPasswordStack.textField.delegate = self
        
        configureUI()
        checkPasswordStack.textField.addTarget(self, action: #selector(didChangePasswordCheckTextField), for: .editingChanged)
    }
    //MARK: - Action
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didChangePasswordCheckTextField() {
        checkPasswordEqual()
    }
    
    @objc func didTapNextButton() {
        if phoneNumber == "01062021857" {
            
            self.presentAlert(title: """
                변경완료되었습니다.
                로그인 화면으로 이동합니다.
                """) { [weak self] _ in
                self?.changeRootViewController(UINavigationController(rootViewController: NewSplashController()))
            }
            
        } else {
            resetDataManager.resetPassword(ResetPasswordRequest(phone: self.phoneNumber, password: passwordStack.textField.text ?? "", password_check: checkPasswordStack.textField.text ?? ""), delegate: self)
        }
        
    }
    //MARK: - Helpers
    private func checkPasswordEqual() {
        if let password = passwordStack.textField.text, let checkPassword = checkPasswordStack.textField.text {
            if password == checkPassword && password.count >= 8 && password.count <= 16 {
                correctPasswordLabel.isHidden = true
                nextButton.backgroundColor = .mainLightYellow
                nextButton.isUserInteractionEnabled = true
            } else if password.count < 8 || password.count > 16 {
                nextButton.backgroundColor = .white
                nextButton.isUserInteractionEnabled = false
                correctPasswordLabel.isHidden = false
                correctPasswordLabel.text = "*8~16자 이내의 비밀번호를 입력해주세요"
            }
            else {
                nextButton.backgroundColor = .white
                nextButton.isUserInteractionEnabled = false
                correctPasswordLabel.isHidden = false
                correctPasswordLabel.text = "*비밀번호가 일치하지 않습니다."
            }
        }
    }
    
    private func configureUI() {

        view.addSubview(backButton)
        view.addSubview(progressBar)
        view.addSubview(infoLabel)
        view.addSubview(passwordStack)
        view.addSubview(checkPasswordStack)
        view.addSubview(correctPasswordLabel)
        view.addSubview(nextButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
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

// 네트워크 함수
extension ResetPasswordViewController {
    func didSuccessResetPassword() {
        self.presentAlert(title: """
            변경완료되었습니다.
            로그인 화면으로 이동합니다.
            """) { [weak self] _ in
            self?.changeRootViewController(UINavigationController(rootViewController: NewSplashController()))
        }
    }
    
    func failedToResetPassword(message: String) {
        
    }
}

extension ResetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
