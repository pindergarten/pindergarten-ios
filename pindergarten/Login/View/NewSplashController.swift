//
//  NewSplashController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class NewSplashController: BaseViewController {
    //MARK: - Properties
    lazy var loginDataManager: LoginDataManager = LoginDataManager()
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "login-Logo"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let phoneNumberStack: CustomInputView = {
        let stack = CustomInputView(title: "아이디", placeholder: "휴대폰 번호", spacing: 11, login: true)
        stack.backgroundColor = .white
        stack.layer.applyShadow(color: .black, alpha: 0.05, x: 0, y: 4, blur: 20)
        stack.layer.cornerRadius = 15
        stack.textField.keyboardType = .numberPad
        return stack
    }()
    
    private let passwordStack: CustomInputView = {
        let stack = CustomInputView(title: "비밀번호", placeholder: "8~16자 이내의 비밀번호", isSecure: true, spacing: 11, login: true)
        stack.backgroundColor = .white
        stack.layer.applyShadow(color: .black, alpha: 0.05, x: 0, y: 4, blur: 20)
        stack.layer.cornerRadius = 15
        stack.textField.returnKeyType = .done
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSMutableAttributedString(string: "로그인", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!]), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.mainLightYellow.cgColor
        button.layer.borderWidth = 3
        button.layer.applyShadow(color: .black, alpha: 0.05, x: 0, y: 4, blur: 20)
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var findPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSMutableAttributedString(string: "비밀번호 찾기", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!]), for: .normal)
        button.backgroundColor = .mainLightYellow
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 25
        button.layer.applyShadow(color: .black, alpha: 0.05, x: 0, y: 4, blur: 20)
        button.addTarget(self, action: #selector(didTapFindPasswordButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSMutableAttributedString(string: "회원가입", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!]), for: .normal)
        button.backgroundColor = .mainLightYellow
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 25
        button.layer.applyShadow(color: .black, alpha: 0.05, x: 0, y: 4, blur: 20)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberStack.textField.becomeFirstResponder()
        bind()
        phoneNumberStack.textField.delegate = self
        passwordStack.textField.delegate = self
        configureUI()
    }
    //MARK: - Action
    
    @objc func didTapFindPasswordButton(sender: Any?) {
        navigationController?.pushViewController(FindPasswordViewController(), animated: true)
    }
    
    @objc func didTapSignUpButton(sender: Any?) {
        navigationController?.pushViewController(SignUpNumberViewController(), animated: true)
    }
    
    @objc func didTapLoginButton() {
        loginDataManager.login(LoginRequest(phone: phoneNumberStack.textField.text ?? "", password: passwordStack.textField.text ?? ""), delegate: self)
    }
    
    //MARK: - Helpers
    private func bind() {
        phoneNumberStack.textField.rx.text
            .orEmpty
            .bind(to: loginViewModel.phoneNumberTextObserver)
            .disposed(by: disposeBag)
        
        passwordStack.textField.rx.text
            .orEmpty
            .bind(to: loginViewModel.passwordTextObserver)
            .disposed(by: disposeBag)
        
        loginViewModel.isValid.bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginViewModel.isValid
            .map { $0 ? UIColor.mainLightYellow : UIColor.white}
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap.subscribe(
            onNext: { [weak self] _ in
                self?.loginDataManager.login(LoginRequest(phone: (self?.loginViewModel.phoneNumberTextObserver.value)!, password: (self?.loginViewModel.passwordTextObserver.value)!), delegate: self!)
            }
        ).disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.addSubview(logoImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(phoneNumberStack)
        containerView.addSubview(passwordStack)
        containerView.addSubview(loginButton)
        containerView.addSubview(findPasswordButton)
        containerView.addSubview(signUpButton)
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(50 * Device.height / Constant.HEIGHT)
            make.width.equalTo(132 * Device.width / Constant.WIDTH)
            make.height.equalTo(175 * Device.height / Constant.HEIGHT)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView)
        }
        
      
        phoneNumberStack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40 * Device.height / Constant.HEIGHT)
            make.left.right.equalTo(view).inset(20)
        }
        
        passwordStack.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberStack.snp.bottom).offset(14 * Device.height / Constant.HEIGHT)
            make.left.right.equalTo(view).inset(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordStack.snp.bottom).offset(36 * Device.height / Constant.HEIGHT)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(14 * Device.height / Constant.HEIGHT)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(findPasswordButton.snp.bottom).offset(14 * Device.height / Constant.HEIGHT)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(containerView).offset(-40)
        }
    }
}

extension NewSplashController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// 네트워크 함수
extension NewSplashController {
    func didSuccessLogin(_ result: LoginResult) {
        
        JwtToken.token = result.jwt
        JwtToken.userId = result.userId
        
        UserDefaults.standard.set(result.jwt, forKey: "token")
        UserDefaults.standard.set(result.userId, forKey: "userId")
        UserDefaults.standard.set(true, forKey: "onboarding")
        
        changeRootViewController(HomeTabBarController())
    }
    
    func failedToLogin(message: String) {
        self.presentAlert(title: message)
    }
}


