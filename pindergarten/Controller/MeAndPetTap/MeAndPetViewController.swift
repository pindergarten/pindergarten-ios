//
//  MeAndPetViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/31.
//

import UIKit

class MeAndPetViewController: BaseViewController {
    
    //MARK: - Properties
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
        
        myFeedCollectionView.register(MyFeedCell.self, forCellWithReuseIdentifier: MyFeedCell.identifier)
        myFeedCollectionView.contentInset = UIEdgeInsets(top: 20, left: 12, bottom: 40, right: 12)
        
        
        // Set the PinterestLayout delegate
        if let layout = myFeedCollectionView.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
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
extension MeAndPetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedCell.identifier, for: indexPath) as! MyFeedCell

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailFeedViewController()
       
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
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
