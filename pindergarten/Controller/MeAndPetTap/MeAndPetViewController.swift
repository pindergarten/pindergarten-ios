//
//  MeAndPetViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/31.
//

import UIKit

class MyPetCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "MyPetCell"
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "1"))
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(height: 42, width: 42)
        iv.layer.cornerRadius = 21
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x2D2D2D, alpha: 0.5)
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        label.text = "꿀떡"
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Action
    
    //MARK: - Helpers
    private func configureUI() {
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
        
    }
}

class MeAndPetViewController: BaseViewController {
    
    //MARK: - Properties
    lazy var getAllMyPetsDataManager: GetAllMyPetsDataManager = GetAllMyPetsDataManager()
    var allMyPets = [GetAllMyPetsResult]()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 26
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        label.textColor = UIColor(hex: 0x2D2D2D, alpha: 0.89)
        label.text = "nick_Name"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "meAndPet-Plus"), for: .normal)
        return button
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "meAndPet-Setting"), for: .normal)
        return button
    }()
    
    private lazy var registerPetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "펫을 등록 해주세요", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)!]), for: .normal)
        button.tintColor = UIColor(hex: 0x545454)

        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.mainLightYellow.cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(didTapRegisterPetButton), for: .touchUpInside)
        return button
    }()
    
    private let myPetCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    
    private let myFeedCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PinterestLayout())
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        myFeedCollectionView.delegate = self
        myFeedCollectionView.dataSource = self
        
        myPetCollectionView.delegate = self
        myPetCollectionView.dataSource = self
        
        myFeedCollectionView.register(MyFeedCell.self, forCellWithReuseIdentifier: MyFeedCell.identifier)
        myFeedCollectionView.contentInset = UIEdgeInsets(top: 20, left: 12, bottom: 40, right: 12)
        
        myPetCollectionView.register(MyPetCell.self, forCellWithReuseIdentifier: MyPetCell.identifier)
        
        
        
        
        // Set the PinterestLayout delegate
        if let layout = myFeedCollectionView.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        getAllMyPetsDataManager.getAllMyPet(delegate: self)
    }
    
    //MARK: - Action
    @objc private func didTapRegisterPetButton() {
        navigationController?.pushViewController(PetRegisterController(), animated: true)
    }
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(plusButton)
        view.addSubview(settingButton)
        view.addSubview(registerPetButton)
        view.addSubview(myPetCollectionView)
        view.addSubview(separateLine)
        view.addSubview(myFeedCollectionView)
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(30)
            make.left.equalTo(view).offset(20)
            make.width.height.equalTo(52)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.left.equalTo(profileImage.snp.right).offset(11)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.right.equalTo(settingButton.snp.left).offset(-30)
            make.width.height.equalTo(20)
        }
        
        settingButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(20)
        }
        
        registerPetButton.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(22)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        myPetCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(separateLine.snp.top)
        }
        
        separateLine.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(registerPetButton.snp.bottom).offset(24)
            make.height.equalTo(2)
        }
        
        myFeedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - Extenseion
extension MeAndPetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myFeedCollectionView {
            return 10
        } else {
            return allMyPets.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myFeedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedCell.identifier, for: indexPath) as! MyFeedCell
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPetCell.identifier, for: indexPath) as! MyPetCell
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: URL(string: allMyPets[indexPath.item].profileImage), placeholder: nil, options: [.transition(.fade(0.7)), .loadDiskFileSynchronously], progressBlock: nil)
          
            cell.nameLabel.text = allMyPets[indexPath.item].name
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width / 4 - 10, height: 100)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailVC = DetailFeedViewController()
//
//        navigationController?.pushViewController(detailVC, animated: true)
//    }

    
}



extension MeAndPetViewController: PinterestLayoutDelegate {
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
extension MeAndPetViewController {
    func didSuccessGetAllMyPet(_ result: [GetAllMyPetsResult]) {
        allMyPets = result
        
        if allMyPets.count == 0 {
            myPetCollectionView.isHidden = true
            registerPetButton.isHidden = false
        } else {
            myPetCollectionView.isHidden = false
            registerPetButton.isHidden = true
        }
        
        myPetCollectionView.reloadData()
        print(allMyPets)
    }
    
    func failedToGetAllMyPet(message: String) {
        self.presentAlert(title: message)
    }
        
}
