//
//  PindergartenViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/31.
//

import UIKit
import Kingfisher

var imageList: [UIImage] = [#imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "backgroundImage"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "1")]
//var imageList: [UIImage] = []


class HomeViewController: BaseViewController {

    
    //MARK: - Properties
    lazy var getAllFeedDataManager: GetAllFeedDataManager = GetAllFeedDataManager()
    lazy var likeDataManager: LikeDataManager = LikeDataManager()
    
    var postId: Int = 0
    private var feed: [GetAllFeedResult] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainTextColor
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        label.attributedText = NSAttributedString(
            string: "펫 유치원, 이제 핀더가든 앱으로 편리하게 보내세요",
            attributes: [.font : UIFont(name: "AppleSDGothicNeoEB00", size: 18)!, .paragraphStyle : paragraphStyle])
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
       
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var eventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "eventButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapEventButton), for: .touchUpInside)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PinterestLayout())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getAllFeedDataManager.getAllFeed(delegate: self)
        
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 40, right: 12)
        
        
        // Set the PinterestLayout delegate
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        getAllFeedDataManager.getAllFeed(delegate: self)
    }
    
    //MARK: - Action
    @objc func didTapPlusButton() {
        
    }
    
    @objc func didTapEventButton() {
        navigationController?.pushViewController(EventViewController(), animated: true)
    }
    
//    @objc func didTapHeartButton(sender: UIButton) {
//        likeDataManager.like(postId: sender.tag, delegate: self)
//    }
    
    //MARK: - Helpers
    func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(plusButton)
        view.addSubview(eventButton)
        view.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(plusButton.snp.left).offset(-40)
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.topMargin)
            make.right.equalTo(eventButton.snp.left).offset(-25)
            make.height.width.equalTo(20)
        }
        
        eventButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.topMargin)
            make.right.equalTo(view).offset(-20)
            make.height.width.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view)
        }
    }
}

//MARK: - Extenseion
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        cell.bringSubviewToFront(cell.heartButton)
        cell.delegate = self
        
        cell.profileImageView.kf.setImage(with: URL(string: feed[indexPath.item].profileimg))
        cell.imageView.kf.setImage(with: URL(string: feed[indexPath.item].thumbnail))
        cell.nameLabel.text = feed[indexPath.item].nickname
        cell.scriptionLabel.text = feed[indexPath.item].content
        cell.heartButton.tag = feed[indexPath.item].id
        
        if feed[indexPath.item].isLiked == 0 {
            cell.heartButton.setImage(#imageLiteral(resourceName: "heartButton"), for: .normal)
        } else if feed[indexPath.item].isLiked == 1 {
            cell.heartButton.setImage(#imageLiteral(resourceName: "filledHeartButton"), for: .normal)
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailFeedViewController()
        detailVC.postId = feed[indexPath.item].id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: HomeCellDelegate {
    func didTapHeartButton(tag: Int) {
        print(tag)
        likeDataManager.like(postId: tag, delegate: self)
    }
}

extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        let cellWidth: CGFloat = (view.bounds.width - 4) / 2 // 셀 가로 크기
        let imageHeight = imageList[indexPath.item].size.height
        let imageWidth = imageList[indexPath.item].size.width
        // 이미지 비율
        let imageRatio = imageHeight/imageWidth


        return imageRatio * cellWidth
    }
}

// 네트워크 함수
extension HomeViewController {
    func didSuccessGetAllFeed(_ result: [GetAllFeedResult]) {
        print("DEBUG: GET ALL FEED")
        feed = result
    
        collectionView.reloadData()
        
    }
    
    func failedToGetAllFeed(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED TO GET ALL FEED")
    }
    
    func didSuccessLike(_ result: LikeResult) {
        print("DEBUG: Like DETAIL FEED")
        print(result.isSet)
        getAllFeedDataManager.getAllFeed(delegate: self)
    }
    
    func failedToLike(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED TO Like DETAIL FEED")
    }
}

//#if DEBUG
//import SwiftUI
//struct PindergartenViewControllerRepresentable: UIViewControllerRepresentable {
//
//func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//}
//@available(iOS 13.0.0, *)
//func makeUIViewController(context: Context) -> UIViewController{
//    PindergartenViewController()
//    }
//}
//@available(iOS 13.0, *)
//struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            if #available(iOS 14.0, *) {
//                PindergartenViewControllerRepresentable()
//                    .ignoresSafeArea()
//                    .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
//                    .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//            } else {
//                PindergartenViewControllerRepresentable()
////                    .ignoresSafeArea()
//                    .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
//                    .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//            }
//        }
//
//    }
//} #endif
