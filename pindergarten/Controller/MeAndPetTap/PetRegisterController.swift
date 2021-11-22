//
//  PetRegisterController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/21.
//

import UIKit

class PetRegisterController: BaseViewController {
    //MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
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
        button.setImage(UIImage(named: "meAndPet-DefaultProfile"), for: .normal)
      
        return button
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "meAndPet-Camera"), for: .normal)
        return button
    }()
    
    let nameInput = CustomInputView(title: "이름", placeholder: "이름을 입력해주세요.", spacing: 16)
    
    let birthInput = CustomInputView(title: "반려견 생년원일", placeholder: "생년월일을 입력해주세요.", spacing: 16)
    
    let genderChoice = CustomButtonChoiceView(title: "성별", choiceItem: ["남자아이", "여자아이"])
    
    let neuteringChoice = CustomButtonChoiceView(title: "중성화 여부", choiceItem: ["했어요", "안했어요"])
    
    let registerChoice = CustomButtonChoiceView(title: "반려견 등록 여부", choiceItem: ["했어요", "안했어요"])
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        birthInput.textField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapDoneBtn() {
        if let datePicker = birthInput.textField.inputView as? UIDatePicker {
            print(datePicker.date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            birthInput.textField.text = dateFormatter.string(from: datePicker.date)
        }
        birthInput.textField.resignFirstResponder()
    }
    
    @objc private func didTapCancelBtn() {
        birthInput.textField.resignFirstResponder()
    }
    //MARK: - Helpers
    func openDataPicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        birthInput.textField.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        let cancelBtn = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapCancelBtn))
        let doneBtn = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(didTapDoneBtn))
        let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let titleButton = UIBarButtonItem(title: "반려견 생년월일을 선택해주세요.", style: .plain, target: nil, action: nil)
        titleButton.isEnabled = false
        titleButton.setTitleTextAttributes([.foregroundColor : UIColor(hex: 0xBFBFBF), .font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!], for: .disabled)
        toolBar.setItems([cancelBtn, flexibleBtn, titleButton, flexibleBtn, doneBtn], animated: true)
        birthInput.textField.inputAccessoryView = toolBar
    
    }
    
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(finishButton)
        view.addSubview(separateLine)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(profileButton)
        containerView.addSubview(cameraButton)
        containerView.addSubview(nameInput)
        containerView.addSubview(genderChoice)
        containerView.addSubview(birthInput)
        containerView.addSubview(neuteringChoice)
        containerView.addSubview(registerChoice)
        
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
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom)
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView)
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(40)
            make.centerX.equalTo(view)
            make.width.height.equalTo(86)
        }
        
        profileButton.layer.cornerRadius = 43
        profileButton.layer.masksToBounds = true
        
        cameraButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(profileButton)
            make.width.height.equalTo(30)
        }
        
        nameInput.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)
        }
        
        genderChoice.snp.makeConstraints { make in
            make.top.equalTo(nameInput.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)
        }
        
        birthInput.snp.makeConstraints { make in
            make.top.equalTo(genderChoice.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)

        }
        
        neuteringChoice.snp.makeConstraints { make in
            make.top.equalTo(birthInput.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)
        }
        
        registerChoice.snp.makeConstraints { make in
            make.top.equalTo(neuteringChoice.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)
            make.bottom.lessThanOrEqualTo(containerView).offset(-20)
        }
        
    }
        
}

extension PetRegisterController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        openDataPicker()
    }
}
