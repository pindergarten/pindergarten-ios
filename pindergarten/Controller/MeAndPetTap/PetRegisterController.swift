//
//  PetRegisterController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/21.
//

import UIKit
import IQKeyboardManagerSwift
import BSImagePicker
import Photos

class PetRegisterController: BaseViewController {
    //MARK: - Properties
    let imagePicker = UIImagePickerController()
    var myPet = PostMyPetRequest(name: "", profileImage: Data(), gender: 2, breed: "", birth: "", vaccination: 2, neutering: 2)
    
    lazy var postMyPetDataManager: PostMyPetDataManager = PostMyPetDataManager()
    
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
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
//    private lazy var profileButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "meAndPet-DefaultProfile"), for: .normal)
//        button.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
//        return button
//    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "meAndPet-DefaultProfile"))
        iv.layer.cornerRadius = 43
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "meAndPet-Camera"), for: .normal)
        button.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
        return button
    }()
    
    let nameInput = CustomInputView(title: "이름", placeholder: "이름을 입력해주세요.", spacing: 16)
    
    let genderChoice = CustomButtonChoiceView(title: "성별", choiceItem: ["남자아이", "여자아이"])
    
    let breedInput = CustomInputView(title: "품종", placeholder: "반려견 견종을 입력해주세요.", spacing: 16)
    
    let birthInput = CustomInputView(title: "반려견 생년원일", placeholder: "생년월일을 입력해주세요.", spacing: 16)
    
    let registerChoice = CustomButtonChoiceView(title: "반려견 등록 여부", choiceItem: ["했어요", "안했어요"])
    
    let neuteringChoice = CustomButtonChoiceView(title: "중성화 여부", choiceItem: ["했어요", "안했어요"])
    
    var newImage: UIImage? = nil // update 할 이미지
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        IQKeyboardManager.shared.enable = true
        setButtonChoiceDelegate()
        setImagePicker()
        configureUI()
        birthInput.textField.delegate = self
        
        nameInput.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        breedInput.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: - Action
    @objc func didTapRegisterButton() {
        postMyPetDataManager.registerPet(name: myPet.name, profileImage: newImage, gender: myPet.gender, breed: myPet.breed, birth: myPet.birth, vaccination: myPet.vaccination, neutering: myPet.neutering, delegate: self) { _ in
            
        }
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        if let name = nameInput.textField.text {
            myPet.name = name.replacingOccurrences(of: " ", with: "")
        }
        
        if let breed = breedInput.textField.text {
            myPet.breed = breed.replacingOccurrences(of: " ", with: "")
        }
        checkInfo()
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
        checkInfo()
    }
    
    @objc private func didTapDoneBtn() {
        if let datePicker = birthInput.textField.inputView as? UIDatePicker {
            print(datePicker.date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            birthInput.textField.text = dateFormatter.string(from: datePicker.date)
            if let birth = birthInput.textField.text {
                myPet.birth = birth
            }
            
            
        }
        birthInput.textField.resignFirstResponder()
        checkInfo()
    }
    
    @objc private func didTapCancelBtn() {
        birthInput.textField.resignFirstResponder()
    }
    
    @objc private func didTapCameraButton() {
        checkAlbumPermission()
    }
    //MARK: - Helpers
    private func setButtonChoiceDelegate() {
        genderChoice.delegate = self
        registerChoice.delegate = self
        neuteringChoice.delegate = self
    }
    
    private func checkInfo() {
        if (myPet.birth != "") && (myPet.gender != 2) && (myPet.breed != "") && (myPet.name != "") && (myPet.neutering != 2) && (myPet.vaccination != 2)  {
            finishButton.isUserInteractionEnabled = true
            finishButton.tintColor = UIColor.mainBrown
        } else {
            finishButton.isUserInteractionEnabled = false
            finishButton.tintColor = UIColor(hex: 0xABABAB)
        }
    }
    
    func checkAlbumPermission(){
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                print("Album: 권한 허용")
                DispatchQueue.main.async {
                    self.present(self.imagePicker, animated: true)
                }
               
            case .denied:
                print("Album: 권한 거부")
            case .restricted, .notDetermined:
                print("Album: 선택하지 않음")
            default:
                break
            }
        })
    }
    private func setImagePicker() {
        imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
        imagePicker.allowsEditing = true // 수정 가능 여부
        imagePicker.delegate = self // picker delegate
    }
    
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
        containerView.addSubview(profileImageView)
        containerView.addSubview(cameraButton)
        containerView.addSubview(nameInput)
        containerView.addSubview(genderChoice)
        containerView.addSubview(breedInput)
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
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(40)
            make.centerX.equalTo(view)
            make.width.height.equalTo(86)
        }
        
        
        cameraButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(profileImageView)
            make.width.height.equalTo(30)
        }
        
        nameInput.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)
        }
        
        genderChoice.snp.makeConstraints { make in
            make.top.equalTo(nameInput.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)
        }
        
        breedInput.snp.makeConstraints { make in
            make.top.equalTo(genderChoice.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)
        }
    
        birthInput.snp.makeConstraints { make in
            make.top.equalTo(breedInput.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)

        }
        
        registerChoice.snp.makeConstraints { make in
            make.top.equalTo(birthInput.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)
        
        }
        
        neuteringChoice.snp.makeConstraints { make in
            make.top.equalTo(registerChoice.snp.bottom).offset(25)
            make.left.right.equalTo(view).inset(20)
            make.bottom.lessThanOrEqualTo(containerView).offset(-40)
        }
        
        
        
    }
        
}

extension PetRegisterController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        openDataPicker()
    }
}


extension PetRegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        self.profileImageView.image = newImage // 받아온 이미지를 update
        let imageData = newImage?.jpegData(compressionQuality: 0.4)
        myPet.profileImage = imageData!
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
        
    }
}

extension PetRegisterController: ButtonChoiceDelegate {
    func choiceButton() {
        myPet.gender = genderChoice.selectedButton
        myPet.neutering = neuteringChoice.selectedButton
        myPet.vaccination = registerChoice.selectedButton
        checkInfo()
    }
    
    
}

// 네트워크 함수
extension PetRegisterController {
    func didSuccessRegisterPet() {
        print("success")
        self.presentAlert(title: "성공적으로 등록되었습니다.") { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func failedToRegisterPet(message: String) {
        self.presentAlert(title: message)
    }
}
