//
//  NickNameViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import UIKit

class NickNameViewController: BaseViewController {
    //MARK: - Properties
    lazy var checkNickNameDataManager: CheckNickNameDataManager = CheckNickNameDataManager()
    lazy var registerUserDataManager: RegisterUserDataManager = RegisterUserDataManager()
    
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
        progressBar.progress = 1.0
        return progressBar
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 59, height: 26))
        label.text = "기본 정보"
        label.textColor = .mainTextColor
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        return label
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 78, height: 14))
        label.text = "계정 이름"
        label.textColor = .subTextColor
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        return label
    }()
    
    private let nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        tf.borderStyle = .none
        tf.textColor = .subTextColor
        tf.keyboardAppearance = .light
        tf.attributedPlaceholder = NSAttributedString(string: "2자이상 입력해주세요.", attributes: [.foregroundColor:UIColor.mainPlaceholerColor, .font:UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!])
        tf.isSecureTextEntry = false
        tf.addTarget(self, action: #selector(didChangeNickNameTextField), for: .editingChanged)
        return tf
    }()
    
    private let checkNickNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSMutableAttributedString(string: "중복확인", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!]), for: .normal)
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: 0xD8D8D8).cgColor
        button.addTarget(self, action: #selector(didTapCheckNickNameButton), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let nickNameLine: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = UIColor(hex: 0xE0E0E0)
        return view
    }()
    
    private let correctNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "*계정 이름에는 영문, 숫자, 밑줄 및 마침표만 사용할 수 있습니다."
        label.textColor = .mainBrown
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return label
    }()
    
    private let agreeLabel: UILabel = {
        let label = UILabel()
        label.text = "*계정을 만들면 핀더가든의 개인 정보 취급 방침 및 이용 약관에 동의하게 됩니다. "
        label.textColor = .mainBrown
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.backgroundColor = .white
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.mainLightYellow.cgColor
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(didTapFinishButton), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboardWhenTappedAround()
        nickNameTextField.becomeFirstResponder()
        
        configureUI()
    }
    //MARK: - Action
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didChangeNickNameTextField() {
        checkNickName()
    }
    
    @objc func didTapCheckNickNameButton() {
        checkNickNameDataManager.checkNickName(CheckNickNameRequest(nickname: nickNameTextField.text ?? ""), delegate: self)
    }
    
    @objc func didTapFinishButton() {
        registerUserDataManager.registerUser(RegisterUserRequest(phone: "01035123584", password: "11111111", password_check: "11111111", nickname: nickNameTextField.text ?? ""), delegate: self)
    }
    //MARK: - Helpers
    private func checkNickName() {
        let nickNamePattern = "^[A-Za-z0-9_.]{2,}$"
        let regex = try? NSRegularExpression(pattern: nickNamePattern)

        if let nickName = nickNameTextField.text {
            if let _ = regex?.firstMatch(in: nickName, options: [], range: NSRange(location: 0, length: nickName.count)) {
                correctNickNameLabel.isHidden = true
                checkNickNameButton.backgroundColor = .mainLightYellow
                checkNickNameButton.isUserInteractionEnabled = true
            } else if nickName.count < 2 && nickName.count > 0{
                correctNickNameLabel.text = "2자이상 입력해주세요."
                correctNickNameLabel.isHidden = false
                checkNickNameButton.backgroundColor = .white
                checkNickNameButton.isUserInteractionEnabled = false
            } else {
                correctNickNameLabel.text = "*계정 이름에는 영문, 숫자, 밑줄 및 마침표만 사용할 수 있습니다."
                correctNickNameLabel.isHidden = false
                checkNickNameButton.backgroundColor = .white
                checkNickNameButton.isUserInteractionEnabled = false
            }
        }
    }
    
    private func configureUI() {

        view.addSubview(backButton)
        view.addSubview(progressBar)
        view.addSubview(infoLabel)
        view.addSubview(nickNameLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(checkNickNameButton)
        view.addSubview(nickNameLine)
        view.addSubview(correctNickNameLabel)
        view.addSubview(agreeLabel)
        view.addSubview(finishButton)
        
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
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(24)
            make.left.equalTo(view).offset(20)
        }
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(20)
        }
        nickNameLine.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(8)
            make.left.equalTo(20)
            make.width.equalTo(234)
        }
        checkNickNameButton.snp.makeConstraints { make in
            make.bottom.equalTo(nickNameLine)
            make.left.equalTo(nickNameLine.snp.right).offset(9)
            make.width.equalTo(92)
            make.height.equalTo(32)
        }
        correctNickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLine.snp.bottom).offset(8)
            make.left.equalTo(view).offset(20)
        }
        agreeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(finishButton.snp.top).offset(-12)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.centerX.equalTo(view)
        }
        finishButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-74)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
    }
}

// 네트워크 함수
extension NickNameViewController {
    func didSuccessRegisterUser() {
        
        self.presentAlert(title: """
            회원가입이 완료 되었습니다!
            로그인 화면으로 이동합니다.
            """) { [weak self] _ in
            self?.changeRootViewController(LoginViewController())
        }
        
    }
    
    func failedToRegisterUser(message: String) {
        print("DEBUG: FAILED TO REGISTER USER")
    }
    
    func didSuccessCheckNickName() {
        self.presentAlert(title: "사용하실 수 있는 계정 이름입니다.") { [weak self] _ in
            self?.checkNickNameButton.setAttributedTitle(NSMutableAttributedString(string: "중복확인 완료", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!]), for: .normal)
            self?.checkNickNameButton.backgroundColor = .white
            self?.checkNickNameButton.isUserInteractionEnabled = false
            self?.finishButton.backgroundColor = .mainLightYellow
            self?.finishButton.isUserInteractionEnabled = true
        }
    }
    
    func failedToCheckNickName(message: String) {
        correctNickNameLabel.isHidden = false
        correctNickNameLabel.text = message
    }
}
