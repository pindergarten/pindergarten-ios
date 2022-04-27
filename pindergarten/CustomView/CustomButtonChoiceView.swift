//
//  CustomButtonChoiceView.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/22.
//

import UIKit
protocol ButtonChoiceDelegate: AnyObject {
    func choiceButton()
}

class CustomButtonChoiceView: UIView {
    //MARK: - Properties
    weak var delegate: ButtonChoiceDelegate?
    var selectedButton: Int = 2
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = .mainTextColor
        return label
    }()
    
    private lazy var choiceButtonL: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .clear
        button.setImage(UIImage(named: "meAndPet-DefaultButton"), for: .normal)
        button.setImage(UIImage(named: "meAndPet-ChoicedButton"), for: .selected)
        button.setDimensions(height: 20, width: 20)
        button.addTarget(self, action: #selector(didTapChoiceButton), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private let choiceLabelL: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = UIColor(hex: 0xBFBFBF)
        label.setWidth(130)
        label.tag = 11
        return label
    }()
    
    private lazy var choiceButtonStackL: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [choiceButtonL, choiceLabelL])
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var choiceButtonR: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .clear
        button.setImage(UIImage(named: "meAndPet-DefaultButton"), for: .normal)
        button.setImage(UIImage(named: "meAndPet-ChoicedButton"), for: .selected)
        
        button.setDimensions(height: 20, width: 20)
        button.addTarget(self, action: #selector(didTapChoiceButton), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    private let choiceLabelR: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = UIColor(hex: 0xBFBFBF)
        label.setWidth(130)
        label.tag = 12
        return label
    }()
    
    private lazy var choiceButtonStackR: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [choiceButtonR, choiceLabelR])
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var choiceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [choiceButtonStackL, choiceButtonStackR])
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var totalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, choiceStack])
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var allStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalStack, line])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private let line: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .mainlineColor
        return view
    }()
    //MARK: - Lifecycle
    init(title: String, choiceItem: [String], spacing: CGFloat = 18) {
        super.init(frame: .zero)
        
        titleLabel.text  = title
        choiceLabelL.text = choiceItem[0]
        choiceLabelR.text = choiceItem[1]
        totalStack.spacing = spacing
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Action
    @objc private func didTapChoiceButton(_ sender: UIButton) {

        selectedButton = sender.tag
        delegate?.choiceButton()
        sender.isSelected = true
        let stackLabel = self.viewWithTag(sender.tag + 10) as? UILabel
        stackLabel?.textColor = UIColor(hex: 0x5A5A5A)
        
        
        for tag in 1...2 {
            if tag != sender.tag {
                let button = self.viewWithTag(tag) as? UIButton
                let label = self.viewWithTag(tag+10) as? UILabel
                button?.isSelected = false
                label?.textColor = UIColor(hex: 0xBFBFBF)
            }
        }
    }
    
    //MARK: - Helpers
    private func configureUI() {
        addSubview(allStack)
     
        allStack.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
