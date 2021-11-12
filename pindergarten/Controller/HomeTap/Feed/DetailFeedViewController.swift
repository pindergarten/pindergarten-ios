//
//  DetailFeedViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/04.
//

import UIKit
import ImageSlideshow
import Kingfisher

class DetailFeedViewController: BaseViewController {
    //MARK: - Properties
    
    lazy var getDetailFeedDataManager: GetDetailFeedDataManager = GetDetailFeedDataManager()
    lazy var likeDataManager: LikeDataManager = LikeDataManager()
    lazy var deleteFeedDataManager: DeleteFeedDataManager = DeleteFeedDataManager()
    
    var postId: Int = 0
    
    private var detailFeed: GetDetailFeedResult?
    
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
    
    private let seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "4")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        label.textColor = .mainTextColor
        label.text = "oneoneni"
        return label
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "menuImage"), for: .normal)
        button.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        return button
    }()

    
    var imageSlide: ImageSlideshow = {
        let image = ImageSlideshow()
        image.contentScaleMode = .scaleAspectFill
        image.circular = false
        return image
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
     
    let heartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x858585)
        return label
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "commentImage"), for: .normal)
        button.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        return button
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x858585)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        label.textColor = UIColor(hex: 0x858585)
        label.text = "2021-10-12"
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(hex: 0x858585)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        label.attributedText = NSMutableAttributedString(string: "잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ", attributes: [.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!, .paragraphStyle: paragraphStyle])
        return label
    }()
    
//    lazy var moreButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setAttributedTitle(NSAttributedString(string: "더보기", attributes: [.font :  UIFont(name: "AppleSDGothicNeo-Regular", size: 11)!]), for: .normal)
//        button.tintColor = UIColor(hex: 0x858585, alpha: 0.5)
//        return button
//    }()
    
    let moreLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "더보기", attributes: [.font :  UIFont(name: "AppleSDGothicNeo-Regular", size: 11)!])
        label.textColor = UIColor(hex: 0x858585, alpha: 0.5)
        return label
    }()
    
    let pageIndicator = UIPageControl()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        getDetailFeedDataManager.getADetailFeed(postId: postId, delegate: self)
        
        
        pageIndicator.currentPageIndicatorTintColor = UIColor.mainLightYellow
        pageIndicator.pageIndicatorTintColor = UIColor(hex: 0xC4C4C4)
        imageSlide.pageIndicator = pageIndicator
        imageSlide.activityIndicator = DefaultActivityIndicator(style: .large, color: .mainLightYellow)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageSlide.addGestureRecognizer(gestureRecognizer)
        let tapMoreLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMoreLabel(sender:)))
        
        moreLabel.isUserInteractionEnabled = true
      
        moreLabel.addGestureRecognizer(tapMoreLabelGestureRecognizer)

        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        getDetailFeedDataManager.getADetailFeed(postId: postId, delegate: self)
        
    }
    
    //MARK: - Action
    @objc private func didTapMenuButton() {
   
        if JwtToken.userId == detailFeed?.userId {
            let actionDelete = UIAlertAction(title: "게시물 삭제하기", style: .destructive) { action in
                self.deleteFeedDataManager.deleteFeed(postId: self.postId, delegate: self)
            }
            
            let actionCancel = UIAlertAction(title: "취소하기", style: .default) { action in
            }
            
              self.presentAlert(
                  preferredStyle: .actionSheet,
                  with: actionDelete, actionCancel
              )
        } else {
            let actionReport = UIAlertAction(title: "신고하기", style: .destructive) { [weak self] action in
                let reportVC = ReportController()
                reportVC.postId = self?.postId ?? 0
                self?.navigationController?.pushViewController(reportVC, animated: true)
            }
            
            let actionCancel = UIAlertAction(title: "취소하기", style: .default) { action in
            }
            
            
              self.presentAlert(
                  preferredStyle: .actionSheet,
                  with: actionReport, actionCancel
              )
        }
    
    }
    
    @objc private func didTapImage() {
        imageSlide.presentFullScreenController(from: self)
    }
    
    @objc private func didTapMoreLabel(sender: UITapGestureRecognizer) {
        
        moreLabel.isHidden = true
        contentLabel.numberOfLines = 0
        contentLabel.snp.remakeConstraints { remake in
            remake.top.equalTo(heartButton.snp.bottom).offset(16)
            remake.left.equalTo(containerView).offset(20)
            remake.right.equalTo(containerView).offset(-57)
            remake.bottom.lessThanOrEqualTo(containerView).offset(-20)
        }
        
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapHeartButton(isSet: Int) {
        likeDataManager.like(postId: postId, delegate: self)
        print("DEBUG: TAPPED HEART BUTTON")
    }
    
    @objc func didTapCommentButton() {
        let commentVC = CommentController()
        commentVC.postId = postId
        navigationController?.pushViewController(commentVC, animated: true)
        print("DEBUG: TAPPED COMMENT BUTTON")
    }
    
    //MARK: - Helpers
    private func configureUI() {
        
        view.addSubview(backButton)
        view.addSubview(seperateLine)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(menuButton)
        containerView.addSubview(imageSlide)
        containerView.addSubview(heartButton)
        containerView.addSubview(heartLabel)
        containerView.addSubview(pageIndicator)
        containerView.addSubview(commentButton)
        containerView.addSubview(commentLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(contentLabel)
//        addSubview(moreButton)
        containerView.addSubview(moreLabel)
        
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom)
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
            make.top.equalTo(containerView).offset(20)
            make.left.equalTo(view).offset(20)
            make.width.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(6)
        }
        
        menuButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.right.equalTo(view).offset(-10)
            make.height.width.equalTo(30)
        }
        
        imageSlide.snp.makeConstraints { make in
            make.width.height.equalTo(view.frame.width)
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(imageSlide.snp.bottom).offset(15)
            make.left.equalTo(view).offset(20)
            make.width.height.equalTo(25)
        }

        heartLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.left.equalTo(heartButton.snp.right).offset(6)
        }

        pageIndicator.snp.makeConstraints { make in
            make.centerY.equalTo(heartLabel)
            make.centerX.equalTo(containerView)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.left.equalTo(heartLabel.snp.right).offset(12)
            make.width.height.equalTo(25)
        }

        commentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.left.equalTo(commentButton.snp.right).offset(6)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.right.equalTo(view).offset(-20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.bottom).offset(16)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-57)
        }
        
        moreLabel.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(contentLabel.snp.bottom)
        }
    }
}

//MARK: - Extension

// 네트워크 함수
extension DetailFeedViewController {
    func didSuccessGetDetailFeed(_ result: GetDetailFeedResult) {
        var imageInputs: [AlamofireSource] = []
        detailFeed = result
        
        if let detailFeed = detailFeed {
            profileImageView.kf.setImage(with: URL(string: detailFeed.profileimg ))
            nameLabel.text = detailFeed.nickname
            heartLabel.text = "\(detailFeed.likeCount)"
            commentLabel.text = "\(detailFeed.commentCount)"
            dateLabel.text = detailFeed.date
            contentLabel.text = detailFeed.content
            for imageURL in detailFeed.imgUrls! {
                imageInputs.append(AlamofireSource(urlString: imageURL.postImageUrl)!)
            }
            imageSlide.setImageInputs(imageInputs)
            
            if detailFeed.isLiked == 0 {
                heartButton.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
            } else if detailFeed.isLiked == 1 {
                heartButton.setImage(#imageLiteral(resourceName: "feedFilledHeartImage"), for: .normal)
            }

        }
        print("DEBUG: GET DETAIL FEED")
    }
    
    func failedToGetDetailFeed(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED TO GET DETAIL FEED")
    }
    
    func didSuccessLike(_ result: LikeResult) {
        
        print("DEBUG: Like DETAIL FEED")
        print(result.isSet)
        
        if result.isSet == 0 {
            heartButton.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
            heartLabel.text = "\(Int(heartLabel.text!)!-1)"
        } else {
            heartButton.setImage(#imageLiteral(resourceName: "feedFilledHeartImage"), for: .normal)
            heartLabel.text = "\(Int(heartLabel.text!)!+1)"
        }
        
        
    }
    
    func failedToLike(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED TO Like DETAIL FEED")
    }
    
    func didSuccessDeleteFeed() {
        self.presentAlert(title: "게시물이 삭제되었습니다") { alert in
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func failedToDeleteFeed(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED TO DELETE FEED")
    }
}
