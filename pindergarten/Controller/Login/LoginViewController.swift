//
//  LoginViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/26.
//

import UIKit

class LoginViewController: BaseViewController {
    //MARK: - Properties

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.setDimensions(height: 30, width: 30)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
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
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .white
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.mainLightYellow.cgColor
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
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        phoneNumberStack.textField.delegate = self
        configureUI()
        
    }
    
    //MARK: - Action
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapFindPasswordLabel(sender: UITapGestureRecognizer) {
        print("DEBUG")
    }
    
    @objc func didTapGoSignUpLabel(sender: UITapGestureRecognizer) {
        print("gotoSign uP")
    }
    
    //MARK: - Helpers
    private func configureUI() {

        let tapFindPasswordGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapFindPasswordLabel(sender:)))
        let tapGoSignUpGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGoSignUpLabel(sender:)))
        findPasswordLabel.isUserInteractionEnabled = true
        goSignUpLabel.isUserInteractionEnabled = true
        findPasswordLabel.addGestureRecognizer(tapFindPasswordGestureRecognizer)
        goSignUpLabel.addGestureRecognizer(tapGoSignUpGestureRecognizer)
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(phoneNumberStack)
        view.addSubview(passwordStack)
        view.addSubview(loginButton)
        view.addSubview(findPasswordLabel)
        view.addSubview(seperatelineLabel)
        view.addSubview(goSignUpLabel)
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(view).offset(8)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(73)
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
        findPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.left.equalTo(view).offset(120)
        }
        seperatelineLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.left.equalTo(findPasswordLabel.snp.right).offset(14)
        }
        goSignUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.left.equalTo(seperatelineLabel.snp.right).offset(14)
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
