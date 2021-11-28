//
//  SignUpViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/26.
//

import UIKit
import AnyFormatKit

class SignUpNumberViewController: BaseViewController {
    
    deinit {
            print("deinit")
    }
    //MARK: - Properties
    
    lazy var checkUserDataManager: CheckUserDataManager = CheckUserDataManager()
    lazy var sendAuthNumberDataManager: SendAuthNumberDataManager = SendAuthNumberDataManager()
    lazy var checkAuthNumberDataManager: CheckAuthNumberDataManager = CheckAuthNumberDataManager()
    
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
        progressBar.progress = 1/3
        return progressBar
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 59, height: 26))
        label.text = "기본 정보"
        label.textColor = .mainTextColor
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 78, height: 14))
        label.text = "휴대폰 번호"
        label.textColor = .subTextColor
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        tf.borderStyle = .none
        tf.textColor = .subTextColor
        tf.keyboardAppearance = .light
        tf.attributedPlaceholder = NSAttributedString(string: "휴대폰 번호를 입력해주세요.", attributes: [.foregroundColor:UIColor.mainPlaceholerColor, .font:UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!])
        tf.isSecureTextEntry = false
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(didChangePhoneNumberTextField), for: .editingChanged)
        return tf
    }()
    
    private let sendAuthNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSMutableAttributedString(string: "인증번호 전송", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!]), for: .normal)
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: 0xD8D8D8).cgColor
        button.addTarget(self, action: #selector(didTapSendNumber), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let phoneNumberLine: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = UIColor(hex: 0xE0E0E0)
        return view
    }()
    
    private let authNumberTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 180, height: 20))
        tf.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        tf.borderStyle = .none
        tf.textColor = .subTextColor
        tf.keyboardAppearance = .light
        tf.attributedPlaceholder = NSAttributedString(string: "인증번호", attributes: [.foregroundColor:UIColor.mainPlaceholerColor, .font:UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!])
        tf.isSecureTextEntry = false
        tf.keyboardType = .numberPad
        tf.returnKeyType = .continue
        tf.addTarget(self, action: #selector(didChangeAuthNumberTextField), for: .editingChanged)
        return tf
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        label.text = "02:55"
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = .subTextColor
        return label
    }()
    
    private let authNumberLine: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = UIColor(hex: 0xE0E0E0)
        return view
    }()
    
    private let checkAuthNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSMutableAttributedString(string: "인증확인", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!]), for: .normal)
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: 0xD8D8D8).cgColor
        button.addTarget(self, action: #selector(didTapCheckNumber), for: .touchUpInside)
        return button
    }()
    
    private let correctPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "*정확히 입력해주세요"
        label.textColor = .mainBrown
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return label
    }()
    
    private let correctAuthNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "*인증번호를 정확히 입력해주세요"
        label.textColor = .mainBrown
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return label
    }()

//    private let nextButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("다음", for: .normal)
//        button.backgroundColor = .white
//        button.tintColor = .mainTextColor
//        button.layer.cornerRadius = 10
//        button.layer.borderWidth = 3
//        button.layer.borderColor = UIColor.mainLightYellow.cgColor
//        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
//        return button
//    }()
    
    private var isCorrectPhoneNumber: Bool = false
    private var isCorrectAuthNumber: Bool = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboardWhenTappedAround()
//        phoneNumberTextField.delegate = self
        phoneNumberTextField.becomeFirstResponder()
        phoneNumberTextField.delegate = self
        authNumberTextField.delegate = self
        
        
        configureUI()

    }
    //MARK: - Action
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didChangePhoneNumberTextField() {
        sendAuthNumberButton.backgroundColor = .white
        let phoneNumberPattern = "^[0-9]{11}$"
        let regex = try? NSRegularExpression(pattern: phoneNumberPattern)
        
        if let _ = regex?.firstMatch(in: phoneNumberTextField.text ?? "", options: [], range: NSRange(location: 0, length: phoneNumberTextField.text?.count ?? 0)) {
            
            if phoneNumberTextField.text?.count == 11 {
                sendAuthNumberButton.layer.borderWidth = 0
                sendAuthNumberButton.backgroundColor = .mainLightYellow
                isCorrectPhoneNumber = true
                sendAuthNumberButton.isUserInteractionEnabled = true
                correctPhoneNumberLabel.isHidden = true
            } else {
                sendAuthNumberButton.layer.borderWidth = 1
                isCorrectPhoneNumber = false
                sendAuthNumberButton.isUserInteractionEnabled = false
                correctPhoneNumberLabel.isHidden = false
            }
        } else {
            sendAuthNumberButton.layer.borderWidth = 1
            isCorrectPhoneNumber = false
            sendAuthNumberButton.isUserInteractionEnabled = false
            correctPhoneNumberLabel.isHidden = false
        }
 
    }
    
    @objc func didChangeAuthNumberTextField() {
        checkAuthNumberButton.backgroundColor = .white
        if authNumberTextField.text?.count == 4 {
            checkAuthNumberButton.layer.borderWidth = 0
            checkAuthNumberButton.backgroundColor = .mainLightYellow
            isCorrectAuthNumber = true
            checkAuthNumberButton.isUserInteractionEnabled = true
            correctAuthNumberLabel.isHidden = true
        } else {
            checkAuthNumberButton.layer.borderWidth = 1
            isCorrectAuthNumber = false
            checkAuthNumberButton.isUserInteractionEnabled = false
            correctAuthNumberLabel.isHidden = false
        }
    }
    
    @objc func didTapSendNumber() {
        
        checkUserDataManager.checkUser(CheckUserRequest(phone: phoneNumberTextField.text ?? ""), delegate: self)
    }
    
    @objc func didTapCheckNumber() {
        checkAuthNumberDataManager.checkAuthNumber(CheckAuthNumberRequest(phone: phoneNumberTextField.text ?? "", verifyCode: authNumberTextField.text ?? ""), delegate: self)
    }
    

//    @objc func didTapNextButton() {
//
//    }
    //MARK: - Helpers
    private func configureUI() {

        authNumberTextField.isHidden = true
        timeLabel.isHidden = true
        authNumberLine.isHidden = true
        checkAuthNumberButton.isHidden = true
        correctPhoneNumberLabel.isHidden = true
        correctAuthNumberLabel.isHidden = true
        
        view.addSubview(backButton)
        view.addSubview(progressBar)
        view.addSubview(infoLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(phoneNumberLine)
        view.addSubview(sendAuthNumberButton)
        view.addSubview(authNumberTextField)
        view.addSubview(timeLabel)
        view.addSubview(authNumberLine)
        view.addSubview(checkAuthNumberButton)
        view.addSubview(correctPhoneNumberLabel)
        view.addSubview(correctAuthNumberLabel)
//        view.addSubview(nextButton)

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
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(24)
            make.left.equalTo(view).offset(20)
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(20)
        }
        
        phoneNumberLine.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(8)
            make.left.equalTo(20)
            make.width.equalTo(234)
        }
        sendAuthNumberButton.snp.makeConstraints { make in
            make.bottom.equalTo(phoneNumberLine)
            make.left.equalTo(phoneNumberLine.snp.right).offset(9)
            make.width.equalTo(92)
            make.height.equalTo(32)
        }
        
        authNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLine.snp.bottom).offset(28)
            make.left.equalTo(view).offset(20)
        }
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(authNumberTextField)
            make.right.equalTo(authNumberLine.snp.right).offset(-5)
        }
        authNumberLine.snp.makeConstraints { make in
            make.top.equalTo(authNumberTextField.snp.bottom).offset(8)
            make.left.equalTo(20)
            make.width.equalTo(234)
        }
        checkAuthNumberButton.snp.makeConstraints { make in
            make.bottom.equalTo(authNumberLine.snp.bottom)
            make.left.equalTo(authNumberLine.snp.right).offset(9)
            make.width.equalTo(92)
            make.height.equalTo(32)
        }
        
        correctPhoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLine.snp.bottom).offset(8)
            make.left.equalTo(view).offset(20)
        }

        correctAuthNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(authNumberLine.snp.bottom).offset(8)
            make.left.equalTo(view).offset(20)
        }
//        nextButton.snp.makeConstraints { make in
//            make.bottom.equalTo(view).offset(-74)
//            make.left.equalTo(view).offset(20)
//            make.right.equalTo(view).offset(-20)
//            make.height.equalTo(50)
//        }
    }
}

// 휴대폰 번호 형식 맞추기
extension SignUpNumberViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        guard let text = textField.text else {
//            return false
//        }
//        let characterSet = CharacterSet(charactersIn: string)
//        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
//            return false
//        }
//
//        let formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
//        let result = formatter.formatInput(currentText: text, range: range, replacementString: string)
//        textField.text = result.formattedText
//        let position = textField.position(from: textField.beginningOfDocument, offset: result.caretBeginOffset)!
//        textField.selectedTextRange = textField.textRange(from: position, to: position)
//        return false
//    }
}

extension SignUpNumberViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// 네트워크 함수
extension SignUpNumberViewController {
    
    func didSuccessCheckUser() {
        self.sendAuthNumberDataManager.sendAuthNumber(SendAuthNumberRequest(phone: phoneNumberTextField.text ?? ""), delegate: self)
    }
    
    func failedToCheckUser(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessSendAuthNumber() {
        print("DEBUG: SENDED AUTH NUMBER")
       
        sendAuthNumberButton.layer.borderWidth = 1
        sendAuthNumberButton.isUserInteractionEnabled = false
        sendAuthNumberButton.backgroundColor = .white
        authNumberTextField.isHidden = false
        timeLabel.isHidden = false
        authNumberLine.isHidden = false
        checkAuthNumberButton.isHidden = false
        
        var remainTime: Int = 175

        let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            DispatchQueue.global().async {
                remainTime -= 1
                if remainTime == 0 {
                    DispatchQueue.main.async {
                        self?.checkAuthNumberButton.backgroundColor = .white
                        self?.checkAuthNumberButton.isUserInteractionEnabled = false
                    }
                    timer.invalidate()
                }
                DispatchQueue.main.async {
                    self?.timeLabel.text = "\(String(format: "%02d", remainTime / 60)):\(String(format: "%02d", remainTime % 60))"
                }
            }
        }
        
    }
    
    func didSuccessCheckAuthNumber() {
        self.presentAlert(title: """
            인증 되었습니다
            회원가입을 완료해주세요
            """) { [weak self] _ in
            self?.timeLabel.text = "02:55"
            let passwordVC = SignUpPasswordViewController()
            passwordVC.phoneNumber = self?.phoneNumberTextField.text
            self?.navigationController?.pushViewController(passwordVC, animated: true)
        }
    }
    
    func failedToSendAuthNumber(message: String) {
        self.presentAlert(title: message)
    }
    
    func failedToCheckAuthNumber(message: String) {
        self.presentAlert(title: message)
    }
}
