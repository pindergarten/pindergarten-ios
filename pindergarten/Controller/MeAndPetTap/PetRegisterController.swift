//
//  PetRegisterController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/21.
//

import UIKit

class PetRegisterController: BaseViewController {
    //MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.text = "펫 추가하기"
        label.textColor = .mainTextColor
        return label
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "등록", attributes: [.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)!]), for: .normal)
        button.tintColor = UIColor(hex: 0xABABAB)
//        button.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        return button
    }()
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "meAndPet-ChoicedButton"), for: .normal)
        button.setImage(UIImage(named: "1"), for: .normal)
        return button
    }()
    
    let nameInput = CustomInputView(title: "이름", placeholder: "이름을 입력해주세요.", spacing: 16)
    
    let genderChoice = CustomButtonChoiceView(title: "성별", choiceItem: ["남자아이", "여자아이"])
    
    let neuteringChoice = CustomButtonChoiceView(title: "중성화 여부", choiceItem: ["했어요", "안했어요"])
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(finishButton)
        view.addSubview(separateLine)
        view.addSubview(profileButton)
        view.addSubview(nameInput)
        view.addSubview(genderChoice)
        view.addSubview(neuteringChoice)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton).offset(2)
            make.centerX.equalTo(view)
        }
        
        finishButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(26)
        }
        
        separateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(neuteringChoice.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.height.equalTo(86)
        }
        
        profileButton.layer.cornerRadius = 43
        profileButton.layer.masksToBounds = true
        
        nameInput.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom).offset(10)
            make.left.right.equalTo(view).inset(20)
        }
        
        genderChoice.snp.makeConstraints { make in
            make.top.equalTo(nameInput.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
        }
        
        neuteringChoice.snp.makeConstraints { make in
            make.top.equalTo(genderChoice.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
        }
    }
        
}
