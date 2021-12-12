//
//  PindergartenViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/31.
//

import UIKit
import Kingfisher

//class LoadingFooterView: UICollectionViewCell {
//
//    //MARK: - Properties
//    static let identifier = "LoadingFooterView"
//    var indicator : UIActivityIndicatorView = {
//        let view = UIActivityIndicatorView()
//        view.style = .medium
//        view.color = .mainLightYellow
//        return view
//    }()
//    //MARK: - Lifecycle
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        contentView.addSubview(indicator)
//        indicator.snp.makeConstraints { make in
//            make.center.equalTo(self)
//        }
//        indicator.startAnimating()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

class HomeViewController: BaseViewController {

    //MARK: - Properties
    lazy var getAllFeedDataManager: GetAllFeedDataManager = GetAllFeedDataManager()
    lazy var likeDataManager: LikeDataManager = LikeDataManager()
    
    var postId: Int = 0
    private var feed: [GetAllFeedResult] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainTextColor
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        label.attributedText = NSAttributedString(
            string: "반려견의 하루,\n핀더가든에서 보내세요",
            attributes: [.font : UIFont(name: "AppleSDGothicNeoEB00", size: 18)!, .paragraphStyle : paragraphStyle])
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
       
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plusButton"), for: .normal)
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
        let pinterestLayout = PinterestLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: pinterestLayout)
       
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 40, right: 12)
        
        return collectionView
    }()
    
    var imageList = [CGFloat]()
    var isHomeVC: Bool = true
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.tabBarController?.delegate = self
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
//        collectionView.register(LoadingFooterView.self, forCellWithReuseIdentifier: LoadingFooterView.identifier)
        
        
        // Set the PinterestLayout delegate
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .mainLightYellow
        collectionView.refreshControl = refreshControl
        // refreshcontrol 위치
        collectionView.backgroundView = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        getAllFeedDataManager.getAllFeed(delegate: self)
    }
    
    //MARK: - Action
    @objc func didPullToRefresh() {
        // re-fetch data
        getAllFeedDataManager.getAllFeed(delegate: self)
        
    }
    
    @objc func didTapPlusButton() {
        navigationController?.pushViewController(PostFeedController(), animated: true)
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
            make.right.equalTo(eventButton.snp.left).offset(-30)
            make.height.width.equalTo(20)
        }
        
        eventButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.topMargin)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(20)
            make.width.equalTo(16)
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
        cell.delegate = self

        cell.profileImageView.kf.indicatorType = .activity
        cell.profileImageView.kf.setImage(with: URL(string: feed[indexPath.item].profileimg), placeholder: UIImage(systemName: "person"), options: [.loadDiskFileSynchronously])

        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(with: URL(string: feed[indexPath.item].thumbnail), placeholder: nil, options: [.transition(.fade(0.7)),.loadDiskFileSynchronously], progressBlock: nil)
        cell.nameLabel.text = feed[indexPath.item].nickname
        cell.scriptionLabel.text = feed[indexPath.item].content
        cell.heartButton.tag = feed[indexPath.item].id
        cell.feedIndex = indexPath.item

        if feed[indexPath.item].isLiked == 0 {
            cell.heartButton.setImage(UIImage(named: "heartButton"), for: .normal)
        } else if feed[indexPath.item].isLiked == 1 {
            cell.heartButton.setImage(UIImage(named: "filledHeartButton"), for: .normal)
        }

        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionFooter {
//            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingFooterView.identifier, for: indexPath) as! LoadingFooterView
////            loadingView = footerView
////            loadingView?.backgroundColor = UIColor.clear
//            return footerView
//        } else {
//            return UICollectionReusableView()
//        }
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailFeedViewController()
        detailVC.delegate = self
        detailVC.postId = feed[indexPath.item].id
        detailVC.index = indexPath
        navigationController?.pushViewController(detailVC, animated: true)
    }
//
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.y // frame영역의 origin에 비교했을때의 content view의 현재 origin 위치
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height // 화면에는 frame만큼 가득 찰 수 있기때문에 frame의 height를 빼준 것
//
//        // 스크롤 할 수 있는 영역보다 더 스크롤된 경우 (하단에서 스크롤이 더 된 경우)
//        if maximumOffset < currentOffset {
//            // viewModel.loadNextPage()
//            print("10")
//
//        }
//    }
    
}

extension HomeViewController: HomeCellDelegate {
    func didTapHeartButton(tag: Int, index: Int) {
        likeDataManager.like(postId: tag, index: index, delegate: self)
    }
}

extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        let cellWidth: CGFloat = (view.bounds.width - 60) / 2 // 셀 가로 크기
        var imageHeight: CGFloat = 0
        var imageWidth: CGFloat = 0

        if indexPath.item % 4 == 0 || indexPath.item % 4 == 3 {
            imageHeight = 150

        } else {
            imageHeight = 200
        }
        
        imageWidth = Device.width / 2 - 60
        
     
//        imageHeight = imageList[indexPath.item]
//        let imageWidth = imageList[indexPath.item].size.width
        
        let imageRatio = imageHeight/imageWidth


        return imageRatio * cellWidth
    }
}

extension HomeViewController: DetailVCDelegate {
    func deleteCache() {
        
    }
    
    
}

extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        if tabBarController.selectedIndex == 0 && isHomeVC == true {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        } else {
            isHomeVC = false
        }
        
        if tabBarController.selectedIndex == 0 {
            isHomeVC = true
        }
    }
}

// 네트워크 함수
extension HomeViewController {
   
    func didSuccessGetAllFeed(_ result: [GetAllFeedResult]) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.feed = result
            
            self.collectionView.refreshControl?.endRefreshing()
        }
        
    }
    
    func failedToGetAllFeed(message: String) {
        self.presentAlert(title: message)

    }
    
    func didSuccessLike(idx: Int, _ result: LikeResult) {

        feed[idx].isLiked = result.isSet

    }
    
    func failedToLike(message: String) {
        self.presentAlert(title: message)
    }
}

