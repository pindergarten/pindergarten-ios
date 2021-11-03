//
//  DetailFeedController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import UIKit
import ImageSlideshow
import Kingfisher

class DetailFeedController: BaseViewController {
    //MARK: - Properties
    lazy var getDetailFeedDataManager: GetDetailFeedDataManager = GetDetailFeedDataManager()
    lazy var likeDataManager: LikeDataManager = LikeDataManager()
    
    var postId: Int = 0
    
    private var detailFeed: GetDetailFeedResult?
    
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
    
    private let feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showIndicator()
        getDetailFeedDataManager.getADetailFeed(postId: postId, delegate: self)
  
        
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(DetailFeedCell.self, forCellReuseIdentifier: DetailFeedCell.identifier)
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(seperateLine)
        view.addSubview(feedTableView)
        
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
        
        feedTableView.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
}

//MARK: - Extension
extension DetailFeedController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var imageInputs: [AlamofireSource] = []
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailFeedCell.identifier, for: indexPath) as! DetailFeedCell
        cell.delegate = self
        
        cell.selectionStyle = .none
        if let detailFeed = detailFeed {
            cell.profileImageView.kf.setImage(with: URL(string: detailFeed.profileimg ))
            cell.nameLabel.text = detailFeed.nickname
            cell.heartLabel.text = "\(detailFeed.likeCount)"
            cell.commentLabel.text = "\(detailFeed.commentCount)"
            cell.dateLabel.text = detailFeed.date
            cell.contentLabel.text = detailFeed.content
            for imageURL in detailFeed.imgUrls! {
                imageInputs.append(AlamofireSource(urlString: imageURL.postImageUrl)!)
            }
            cell.imageSlide.setImageInputs(imageInputs)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170 + Device.width
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailFeedController: DetailFeedCellDelegate {
    func didTapHeartButton() {
        likeDataManager.like(postId: postId, delegate: self)
    }
    
    
}

// 네트워크 함수
extension DetailFeedController {
    func didSuccessGetDetailFeed(_ result: GetDetailFeedResult) {
        self.dismissIndicator()
        print("DEBUG: GET DETAIL FEED")
        detailFeed = result
        self.feedTableView.reloadData()
    }
    
    func failedToGetDetailFeed(message: String) {
        print("DEBUG: FAILED TO GET DETAIL FEED")
    }
    
    func didSuccessLike(_ result: LikeResult) {
        print("DEBUG: Like DETAIL FEED")
        print(result.isSet)
    }
    
    func failedToLike(message: String) {
        print("DEBUG: FAILED TO Like DETAIL FEED")
    }
}
