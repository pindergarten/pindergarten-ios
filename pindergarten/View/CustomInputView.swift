//
//  CustomInputView.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/27.
//

import UIKit

class CustomInputView: UIView {
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = .mainTextColor
        return label
    }()
    
    var textField = UITextField()
    
    private let xButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "x-button"), for: .normal)
        button.tintColor = UIColor(hex: 0xA0A0A0)
        button.setDimensions(height: 18, width: 18)
        return button
    }()

    private let line: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .mainlineColor
        return view
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textField, line])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,textFieldStack])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    //MARK: - init
    init(title: String, placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        
        titleLabel.text  = title
        textField = CustomTextField(placeholder: placeholder, isSecure: isSecure)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
