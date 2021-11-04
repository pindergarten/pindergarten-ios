//
//  LoginViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/26.
//

import UIKit
import AnyFormatKit

class LoginViewController: BaseViewController {
    //MARK: - Properties

//    private let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "backButton"), for: .normal)
//        button.tintColor = .mainTextColor
//        button.setDimensions(height: 30, width: 30)
//        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
//        return button
//    }()
    lazy var loginDataManager: LoginDataManager = LoginDataManager()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 45, height: 26))
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.27
        label.attributedText = NSMutableAttributedString(string: "로그인", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private let phoneNumberStack = CustomInputView(title: "아이디", placeholder: "휴대폰 번호")
    
    private let passwordStack = CustomInputView(title: "비밀번호", placeholder: "8~16자 이내의 비밀번호", isSecure: true)
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = .mainTextColor
        button.setAttributedTitle(NSMutableAttributedString(string: "로그인", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!]), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.mainLightYellow.cgColor
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let findPasswordLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 66, height: 22))
        label.text = "비밀번호 찾기"
        label.textColor = .subLightTextColor
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return label
    }()
    private let goSignUpLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 66, height: 22))
        label.text = "회원가입"
        label.textColor = .subLightTextColor
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return label
    }()
    
    private let seperatelineLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 11))
        var stroke = UIView()
        stroke.bounds = label.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.center = label.center
        label.addSubview(stroke)
        label.bounds = label.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.layer.borderWidth = 1
        stroke.layer.borderColor = UIColor.subLightTextColor.cgColor
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [findPasswordLabel, seperatelineLabel, goSignUpLabel])
        stack.axis = .horizontal
        stack.spacing = 14
        return stack
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.dismissKeyboardWhenTappedAround()
        
//        phoneNumberStack.textField.delegate = self
        phoneNumberStack.textField.becomeFirstResponder()
        
        phoneNumberStack.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordStack.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
      
        configureUI()
        
    }
    
    //MARK: - Action
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapFindPasswordLabel(sender: UITapGestureRecognizer) {
        navigationController?.pushViewController(FindPasswordViewController(), animated: true)
    }
    
    @objc func didTapGoSignUpLabel(sender: UITapGestureRecognizer) {
        navigationController?.pushViewController(SignUpNumberViewController(), animated: true)
    }
    
    @objc func didTapLoginButton() {
//        changeRootViewController(HomeTabBarController())
        loginDataManager.login(LoginRequest(phone: phoneNumberStack.textField.text ?? "", password: passwordStack.textField.text ?? ""), delegate: self)
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        checkLoginInfo()
    }
        
    //MARK: - Helpers
    private func checkLoginInfo() {
        if let password = passwordStack.textField.text, let phoneNumber = phoneNumberStack.textField.text {
            let phoneNumberPattern = "^[0-9]{11}$"
            let regex = try? NSRegularExpression(pattern: phoneNumberPattern)
            
            if let _ = regex?.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count)) {
                
                if password.count >= 8 && password.count <= 16  {
                    loginButton.isUserInteractionEnabled = true
                    loginButton.backgroundColor = .mainLightYellow
                } else {
                    loginButton.isUserInteractionEnabled = false
                    loginButton.backgroundColor = .white
                }

            } else {
                loginButton.isUserInteractionEnabled = false
                loginButton.backgroundColor = .white
            }
        }
    }
    private func configureUI() {

        let tapFindPasswordGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapFindPasswordLabel(sender:)))
        let tapGoSignUpGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGoSignUpLabel(sender:)))
        findPasswordLabel.isUserInteractionEnabled = true
        goSignUpLabel.isUserInteractionEnabled = true
        findPasswordLabel.addGestureRecognizer(tapFindPasswordGestureRecognizer)
        goSignUpLabel.addGestureRecognizer(tapGoSignUpGestureRecognizer)
        
//        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(phoneNumberStack)
        view.addSubview(passwordStack)
        view.addSubview(loginButton)
//        view.addSubview(labelStack)
        view.addSubview(findPasswordLabel)
        view.addSubview(seperatelineLabel)
        view.addSubview(goSignUpLabel)
        
//        backButton.snp.makeConstraints { make in
//            make.centerY.equalTo(titleLabel)
//            make.left.equalTo(view).offset(8)
//        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(33)
            make.centerX.equalTo(view)
        }
        phoneNumberStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Device.height / 4)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        passwordStack.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberStack.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordStack.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
//        labelStack.snp.makeConstraints { make in
//            make.top.equalTo(loginButton.snp.bottom).offset(10)
//            make.centerX.equalTo(view)
//        }
        findPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.right.equalTo(seperatelineLabel.snp.left).offset(-14)
        }
        seperatelineLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        goSignUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.left.equalTo(seperatelineLabel.snp.right).offset(14)
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else {
            return false
        }
        let characterSet = CharacterSet(charactersIn: string)
        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
            return false
        }

        let formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
        let result = formatter.formatInput(currentText: text, range: range, replacementString: string)
        textField.text = result.formattedText
        let position = textField.position(from: textField.beginningOfDocument, offset: result.caretBeginOffset)!
        textField.selectedTextRange = textField.textRange(from: position, to: position)
        return false
    }
}

// 네트워크 함수
extension LoginViewController {
    func didSuccessLogin(_ result: LoginResult) {
        changeRootViewController(HomeTabBarController())
        JwtToken.token = result.jwt
        print("DEBUG: Enable to Login")
    }
    
    func failedToLogin(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED LOGIN")
    }
}
