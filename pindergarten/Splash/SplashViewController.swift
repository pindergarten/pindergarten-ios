//
//  SplashViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import UIKit

class SplashViewController: UIViewController {
    //MARK: - Properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "backgroundImage")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 265, height: 50))
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.67
        label.attributedText = NSMutableAttributedString(string: "핀더가든", attributes: [.paragraphStyle: paragraphStyle])
        label.font = UIFont(name: "Swagger", size: 62)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 249, height: 44))
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        label.attributedText = NSMutableAttributedString(string: "다양한 펫 친구들과 뛰어놀 수 있는 핀더가든으로 오세요!", attributes: [.paragraphStyle: paragraphStyle])
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "BMDoHyeon-OTF", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        button.setAttributedTitle(NSMutableAttributedString(string: "로그인", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!, .paragraphStyle : paragraphStyle]), for: .normal)
        button.backgroundColor = .mainLightYellow
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        button.setAttributedTitle(NSMutableAttributedString(string: "회원가입하기", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!, .paragraphStyle : paragraphStyle]), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .mainTextColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.mainLightYellow.cgColor
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginButton, signUpButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 13
        stack.alpha = 0
        return stack
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseInOut) {
            self.buttonStackView.alpha = 1
        }

    }
    //MARK: - Action
    @objc func didTapLoginButton() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func didTapSignUpButton() {
        navigationController?.pushViewController(SignUpNumberViewController(), animated: true)
    }
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(buttonStackView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(265)
            make.left.equalTo(view).offset(43)
            make.top.equalTo(view).offset(94)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(249)
            make.left.equalTo(view).offset(43)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }

        buttonStackView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(113)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-(Device.height / 12))
        }
    }
}
