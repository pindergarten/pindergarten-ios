//
//  UserPageController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/05.
//

import UIKit


class UserPageController: BaseViewController {
    
    //MARK: - Properties
    lazy var getUserPetsDataManager: GetUserPetsDataManager = GetUserPetsDataManager()
    lazy var getUserFeedDataManager: GetUserPostsDataManager = GetUserPostsDataManager()
    lazy var getUserProfileDataManager: GetMyProfileDataManager = GetMyProfileDataManager()
    lazy var blockUserDataManager: BlockUserDataManager = BlockUserDataManager()
    
    var userId: Int = 0
    var userPets: [GetUserPetResult] = [] {
        didSet {
            myPetCollectionView.reloadData()
        }
    }
    var userPosts: [GetUserPostResult] = [] {
        didSet {
            userFeedCollectionView.reloadData()
        }
    }
    var myProfile: GetUserResult?
    
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
        label.textColor = .mainTextColor
        label.text = "goni"
        return label
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "menuImage"), for: .normal)
        button.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var defaultUserPetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "아직 등록된 반려견이 없어요 :(", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)!]), for: .normal)
        button.tintColor = UIColor(hex: 0x545454)

        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.mainLightYellow.cgColor
        button.layer.borderWidth = 3
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let myPetCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 10)
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let userFeedCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PinterestLayout())
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 17, left: 12, bottom: 40, right: 12)
        return collectionView
    }()
    
    lazy var defaultFeedView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Device.width, height: Device.height - separateLine.frame.origin.y))
        let imageView = UIImageView(image: UIImage(named: "meAndPet-defaultFeed"))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-50)
        }
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserProfileDataManager.getMyProfile(userId: userId, delegate: self)
        getUserPetsDataManager.getUserPet(userId: userId, delegate: self)
        getUserFeedDataManager.getUserPosts(userId: userId, delegate: self)
        
        configureUI()
        
        userFeedCollectionView.delegate = self
        userFeedCollectionView.dataSource = self
        
        myPetCollectionView.delegate = self
        myPetCollectionView.dataSource = self
        
        userFeedCollectionView.register(MyFeedCell.self, forCellWithReuseIdentifier: MyFeedCell.identifier)
        
        myPetCollectionView.register(MyPetCell.self, forCellWithReuseIdentifier: MyPetCell.identifier)
        
        
        
        
        // Set the PinterestLayout delegate
        if let layout = userFeedCollectionView.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false

        
    }
    
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapMenuButton() {
        
        let actionReport = UIAlertAction(title: "신고하기", style: .destructive) { [weak self] action in
            
            let userReportVC = UserReportController()
            userReportVC.userId = self?.userId ?? 0
            self?.navigationController?.pushViewController(userReportVC, animated: true)
            
        }
   
        let actionBlock = UIAlertAction(title: "차단하기", style: .destructive) { [weak self] action in
            let blockAction = UIAlertAction(title: "확인", style: .destructive) { _ in
                self?.blockUserDataManager.blockUser(userId: self!.userId, delegate: self!)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
            
            self?.presentAlert(title: "차단하시겠습니까?", with: blockAction, cancelAction)
            
        }
        
        let actionCancel = UIAlertAction(title: "취소", style: .cancel) { action in
        }
        
        
          self.presentAlert(
              preferredStyle: .actionSheet,
              with: actionReport, actionBlock, actionCancel
          )
    
    }
    //MARK: - Helpers
    
    private func configureUI() {

        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(defaultUserPetButton)
        view.addSubview(myPetCollectionView)
        view.addSubview(separateLine)
        view.addSubview(userFeedCollectionView)
        view.addSubview(defaultFeedView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton).offset(2)
            make.centerX.equalTo(view)
        }
        
        if JwtToken.userId != self.userId {
            view.addSubview(menuButton)
            menuButton.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel)
                make.right.equalTo(view).inset(20)
                make.height.width.equalTo(30)
            }
        }
       
        
        defaultUserPetButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        
        myPetCollectionView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(separateLine.snp.top)
        }
        
        separateLine.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(defaultUserPetButton.snp.bottom).offset(20)
            make.height.equalTo(2)
        }
        
        
        userFeedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
        defaultFeedView.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - Extenseion
extension UserPageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == userFeedCollectionView {
            return userPosts.count
        } else {
            return userPets.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == userFeedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedCell.identifier, for: indexPath) as! MyFeedCell
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: URL(string: userPosts[indexPath.item].thumbnail), placeholder: nil, options: [.loadDiskFileSynchronously], progressBlock: nil)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPetCell.identifier, for: indexPath) as! MyPetCell
            if indexPath.item == userPets.count - 1 {
                cell.separateLine.isHidden = true
            } else {
                cell.separateLine.isHidden = false
            }
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: URL(string: userPets[indexPath.item].profileImage), placeholder: nil, options: [.loadDiskFileSynchronously], progressBlock: nil)
          
            cell.nameLabel.text = userPets[indexPath.item].name
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 95, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == userFeedCollectionView {
            let detailVC = DetailFeedViewController()
            detailVC.postId = userPosts[indexPath.item].id
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let detailPetVC = DetailPetController()
            detailPetVC.petId = userPets[indexPath.item].id
            detailPetVC.deleteButton.isHidden = true
            navigationController?.pushViewController(detailPetVC, animated: true)
        }
        
    }

    
}



extension UserPageController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {

        let cellWidth: CGFloat = (view.bounds.width - 60) / 2 // 셀 가로 크기
        var imageHeight: CGFloat = 0
        var imageWidth: CGFloat = 0


        if indexPath.item % 4 == 0 || indexPath.item % 4 == 3 {
            imageHeight = 150
            imageWidth = Device.width / 2 - 60
        } else {
            imageHeight = 200
            imageWidth = Device.width / 2 - 60
        }

        
//        let imageHeight = imageList[indexPath.item].size.height
//        let imageWidth = imageList[indexPath.item].size.width
        
        let imageRatio = imageHeight/imageWidth


        return imageRatio * cellWidth
    }
}

// 네트워크 함수
extension UserPageController {
    func didSuccessGetMyProfile(_ result: GetUserResult) {
        titleLabel.text = result.nickname
    }
    
    func failedToGetMyProfile(message: String) {
        self.presentAlert(title: message) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func didSuccessGetUserPosts(_ result: [GetUserPostResult]) {
        userPosts = result
        if userPosts.count == 0 {
            userFeedCollectionView.isHidden = true
            defaultFeedView.isHidden = false
        } else {
            userFeedCollectionView.isHidden = false
            defaultFeedView.isHidden = true
        }
    }
    
    func failedToGetUserPost(message: String) {
        self.presentAlert(title: message) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func didSuccessGetAllUserPets(_ result: [GetUserPetResult]) {
        userPets = result
        if userPets.count == 0 {
            myPetCollectionView.isHidden = true
            defaultUserPetButton.isHidden = false
        } else {
            myPetCollectionView.isHidden = false
            defaultUserPetButton.isHidden = true
        }
    }
    
    func failedToGetUserPets(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessBlockUser() {
        self.presentAlert(title: "차단되었습니다.") { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func failedToBlockUser(message: String) {
        self.presentAlert(title: message)
    }
        
}
