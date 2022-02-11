//
//  PindergartenViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/31.
//

import UIKit
import Kingfisher


class HomeViewController: BaseViewController {

    //MARK: - Properties
    lazy var getAllFeedDataManager: GetAllFeedDataManager = GetAllFeedDataManager()
    lazy var likeDataManager: LikeDataManager = LikeDataManager()
    
    var postId: Int = 0
    var currentCursor: Int = 0
    var isLoading = false
    private var feed: [GetAllFeedResult] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var throttleCheck: Bool = true
    let pinterestLayout = PinterestLayout()
    
    var loadingView: HomeFooterCollectionResueableView?
    
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
    
    private lazy var collectionView: UICollectionView = {

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
        pinterestLayout.delegate = self
        self.tabBarController?.delegate = self
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        collectionView.register(HomeFooterCollectionResueableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: HomeFooterCollectionResueableView.identifier)
        

        
        
        // Set the PinterestLayout delegate
//        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
//            layout.delegate = self
//        }
//
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .mainLightYellow
        collectionView.refreshControl = refreshControl
        // refreshcontrol 위치
        collectionView.backgroundView = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
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
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)

        }
        
    }
}

//MARK: - Extenseion
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else { return UICollectionViewCell() }
        cell.delegate = self
      
        let scale = UIScreen.main.scale
        
        cell.profileImageView.kf.indicatorType = .activity
        cell.profileImageView.kf.setImage(with: URL(string: feed[indexPath.item].profileimg), placeholder: nil, options: [.loadDiskFileSynchronously])

        
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(with: URL(string: feed[indexPath.item].thumbnail), placeholder: nil, options: [
            .loadDiskFileSynchronously,
            .transition(.fade(0.7)),
            .processor(ResizingImageProcessor(referenceSize: CGSize(width: Device.width / 2 - 60 * scale, height: 200 * scale), mode: .aspectFill)),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage]
        )
        
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailFeedViewController()
        detailVC.postId = feed[indexPath.item].id
        detailVC.index = indexPath
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: PinterestLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
            print(11)
            if self.isLoading {
                return CGSize.zero
            }
            return CGSize(width: collectionView.frame.size.width, height: 55)
            
        }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("10")
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeFooterCollectionResueableView.identifier, for: indexPath) as? HomeFooterCollectionResueableView else { return UICollectionReusableView() }
            loadingView = footer
//            loadingView?.backgroundColor = UIColor.clear
            
            return footer
        }
        
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        print(12)
            if elementKind == UICollectionView.elementKindSectionFooter {
                loadingView?.spinner.startAnimating()
            }
        }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        print(13)
        if elementKind == UICollectionView.elementKindSectionFooter {
            loadingView?.spinner.stopAnimating()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height - 100 - scrollView.frame.size.height) {
            // fetch more data
            guard !getAllFeedDataManager.isPaginating else { return }
            
            showIndicator()
            
            getAllFeedDataManager.getFeed(pagination: true, cursor: currentCursor, delegate: self)
            
        }
    }


    
}

extension HomeViewController: HomeCellDelegate {
    
    func didTapHeartButton(tag: Int, index: Int) {
        
        if throttleCheck == true {
            
            throttleCheck = false
            
            likeDataManager.like(postId: tag, index: index, delegate: self)
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] timer in
                self?.throttleCheck = true
            }
        }
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
    

extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        if tabBarController.selectedIndex == 0 && isHomeVC == true {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
        } else {
//            isHomeVC = false
        }
        
        if tabBarController.selectedIndex == 0 {
            isHomeVC = true
        }
    }
}

// 네트워크 함수
extension HomeViewController {
   
    func didSuccessGetAllFeed(_ result: [GetAllFeedResult]) {
        print(pinterestLayout.collectionViewContentSize)
        currentCursor = result.last!.id
        print(currentCursor)
        
       
        self.feed = result
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            if self.getAllFeedDataManager.isPaginating {
                self.getAllFeedDataManager.isPaginating = false
            }
            self.collectionView.refreshControl?.endRefreshing()
        }
    
        
    }
    
    func didSuccessGetFeed(_ result: [GetAllFeedResult]) {
        if !self.isLoading {
                self.isLoading = true
        }
        
        if let lastCursor = result.last {
            currentCursor = lastCursor.id
            print(currentCursor)
            
            
            self.feed += result
            self.isLoading = false
            dismissIndicator()
            if self.getAllFeedDataManager.isPaginating {
                self.getAllFeedDataManager.isPaginating = false
            }
        
            
        }
        dismissIndicator()
        
    }
    
    func failedToGetAllFeed(message: String) {
        dismissIndicator()
        self.presentAlert(title: message)

    }
    
    func didSuccessLike(idx: Int, _ result: LikeResult) {
        feed[idx].isLiked = result.isSet

    }
    
    func failedToLike(message: String) {
        self.presentAlert(title: message)
    }
}

