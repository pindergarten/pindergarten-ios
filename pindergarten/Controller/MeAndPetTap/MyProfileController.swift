//
//  UserProfileController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import UIKit
import Photos

class MyProfileController: BaseViewController {
    //MARK: - Properties
    
    lazy var logoutDataManager: LogoutDataManager = LogoutDataManager()
    lazy var withdrawalDataManager: WithdrawalDataManager = WithdrawalDataManager()
    lazy var getMyProfileDataManager: GetMyProfileDataManager = GetMyProfileDataManager()
    lazy var changeProfileImageDataManager: ChangeProfileImageDataManager = ChangeProfileImageDataManager()
    
    let imagePicker = UIImagePickerController()
    var newImage: UIImage? = nil // update 할 이미지
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "완료", attributes: [.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)!]), for: .normal)
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
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "meAndPet-DefaultProfile"))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 51
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "meAndPet-Camera"), for: .normal)
        button.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
        return button
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.textColor = UIColor(hex: 0x3F3F3F)
        label.textAlignment = .center
        label.text = "님,"
        return label
    }()
    
    private var greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.textColor = UIColor(hex: 0x3F3F3F)
        label.textAlignment = .center
        label.text = "안녕하세요!"
        return label
    }()
    
    private lazy var greetingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, greetingLabel])
        stack.axis = .vertical
        stack.spacing = 1
        return stack
    }()
    
    private let nameInput = CustomInputView(title: "계정 이름", placeholder: "", spacing: 14)
    
    private let phoneInput = CustomInputView(title: "휴대폰 번호", placeholder: "", spacing: 14)
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "비밀번호 변경", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!, .foregroundColor : UIColor(hex: 0x5A5A5A)]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapChangePasswordButton), for: .touchUpInside)
        return button
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .mainlineColor
        return view
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "로그아웃", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!, .foregroundColor : UIColor(hex: 0x5A5A5A)]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        return button
    }()
    
    private let logoutLine: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .mainlineColor
        return view
    }()
    
    private lazy var withdrawalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "회원탈퇴하기", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!, .foregroundColor : UIColor(hex: 0x5A5A5A)]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapWithdrawalButton), for: .touchUpInside)
        return button
    }()
    
    private let withdrawalLine: UIView = {
        let view = UIView()
        view.setHeight(1)
        view.backgroundColor = .mainlineColor
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setImagePicker()
        getMyProfileDataManager.getMyProfile(userId: JwtToken.userId, delegate: self)
        nameInput.textField.isUserInteractionEnabled = false
        phoneInput.textField.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: - Action
    @objc private func didTapChangePasswordButton() {
    }
    
    @objc private func didTapWithdrawalButton() {
        let actionWithdrawal = UIAlertAction(title: "회원탈퇴", style: .destructive) { [weak self] action in
            self?.withdrawalDataManager.withdrawal(userId: JwtToken.userId, delegate: self!)
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "userId")
        }

        let actionCancel = UIAlertAction(title: "취소", style: .cancel) { action in
        }

        self.presentAlert(
            preferredStyle: .actionSheet,
            with: actionWithdrawal, actionCancel
        )
      
    }
    
    @objc private func didTapLogoutButton() {
        let actionLogout = UIAlertAction(title: "로그아웃", style: .destructive) { [weak self] action in
            self?.logoutDataManager.logout(delegate: self!)
            
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "userId")
        
        }

        let actionCancel = UIAlertAction(title: "취소", style: .cancel) { action in
        }

        self.presentAlert(
            preferredStyle: .actionSheet,
            with: actionLogout, actionCancel
        )
       
    }
    
    @objc private func didTapCameraButton() {
        checkAlbumPermission()
    }
    
    @objc func didTapRegisterButton() {
        let actionRegister = UIAlertAction(title: "수정하기", style: .default) { [weak self] action in
            self?.changeProfileImageDataManager.changeProfile(userId: JwtToken.userId, profileImage: self?.newImage, delegate: self!) { _ in
            }
            self?.finishButton.tintColor = UIColor(hex: 0xABABAB)
            
            self?.finishButton.isUserInteractionEnabled = false
        }

        let actionCancel = UIAlertAction(title: "취소", style: .default) { action in
        }

        self.presentAlert(
            preferredStyle: .actionSheet,
            with: actionRegister, actionCancel
        )
    
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    //MARK: - Helpers
    func setAuthAlertAction() {
        let authAlertController: UIAlertController
        authAlertController = UIAlertController(title: "사진첩 권한 요청", message: "사진첩 권한이 거부 상태입니다.\n환경설정으로 이동하시겠습니까?", preferredStyle: .alert)
        
        let getAuthAction: UIAlertAction
        getAuthAction = UIAlertAction(title: "예", style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        authAlertController.addAction(getAuthAction)
        authAlertController.addAction(cancelAction)
        
        self.present(authAlertController, animated: true, completion: nil)
    }
    
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(finishButton)
        view.addSubview(separateLine)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(cameraButton)
        containerView.addSubview(greetingStack)
        containerView.addSubview(nameInput)
        containerView.addSubview(phoneInput)
//        containerView.addSubview(changePasswordButton)
//        containerView.addSubview(line)
//        containerView.addSubview(logoutButton)
//        containerView.addSubview(logoutLine)
//        containerView.addSubview(withdrawalButton)
//        containerView.addSubview(withdrawalLine)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        finishButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(26)
        }
        
        separateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
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
            make.top.equalTo(separateLine.snp.bottom).offset(40)
            make.centerX.equalTo(view)
            make.width.height.equalTo(102)
        }
        
        
        cameraButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(profileImageView)
            make.width.height.equalTo(40)
        }
        
        greetingStack.snp.makeConstraints { make in
            make.top.equalTo(cameraButton.snp.bottom).offset(14)
            make.left.right.equalTo(view).inset(20)
        }
        
        nameInput.snp.makeConstraints { make in
            make.top.equalTo(greetingStack.snp.bottom).offset(36)
            make.left.right.equalTo(view).inset(20)
        }
        
        phoneInput.snp.makeConstraints { make in
            make.top.equalTo(nameInput.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(20)
        }
        
//        changePasswordButton.snp.makeConstraints { make in
//            make.top.equalTo(phoneInput.snp.bottom)
//            make.left.right.equalTo(view).inset(20)
//            make.height.equalTo(60)
//        }
        
//        line.snp.makeConstraints { make in
//            make.top.equalTo(changePasswordButton.snp.bottom)
//            make.left.right.equalTo(view).inset(20)
//        }
        
//        logoutButton.snp.makeConstraints { make in
//            make.top.equalTo(phoneInput.snp.bottom)
//            make.left.right.equalTo(view).inset(20)
//            make.height.equalTo(60)
//        }
//
//        logoutLine.snp.makeConstraints { make in
//            make.top.equalTo(logoutButton.snp.bottom)
//            make.left.right.equalTo(view).inset(20)
//        }
//
//        withdrawalButton.snp.makeConstraints { make in
//            make.top.equalTo(logoutLine.snp.bottom)
//            make.left.right.equalTo(view).inset(20)
//            make.height.equalTo(60)
//        }
//
//        withdrawalLine.snp.makeConstraints { make in
//            make.top.equalTo(withdrawalButton.snp.bottom)
//            make.left.right.equalTo(view).inset(20)
//            make.bottom.lessThanOrEqualTo(containerView).offset(-40)
//        }
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
                DispatchQueue.main.async {
                    self.setAuthAlertAction()
                }
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
    

}

//MARK: - Extension
extension MyProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        self.profileImageView.image = newImage // 받아온 이미지를 update
//        let imageData = newImage?.jpegData(compressionQuality: 0.4)
        finishButton.isUserInteractionEnabled = true
        finishButton.tintColor = UIColor.mainBrown
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
        
    }
}

// 네트워크 함수
extension MyProfileController {
    func didSuccessLogout() {
        self.presentAlert(title: "로그아웃에 성공하였습니다.") {[weak self] _ in
            self?.changeRootViewController(UINavigationController(rootViewController: NewSplashController()))
        }
       
    }
    
    func failedToLogout(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessWithdrawal() {
        self.presentAlert(title: "회원 탈퇴에 성공하였습니다.") {[weak self] _ in
            self?.changeRootViewController(UINavigationController(rootViewController: NewSplashController()))
        }
    }
    
    func failedToWithdrawal(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessGetMyProfile(_ result: GetUserResult) {
        nameLabel.text = "\(result.nickname) 님,"
        nameInput.textField.text = result.nickname
        phoneInput.textField.text = result.phone
        profileImageView.kf.setImage(with: URL(string: result.profileImage))
    }
    
    func failedToGetMyProfile(message: String) {
        self.presentAlert(title: message) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func didSuccessChangeProfile() {
        self.presentAlert(title: "수정되었습니다.")
    }
    
    func failedToChangeProfile(message: String) {
        self.presentAlert(title: message)
    }
}


