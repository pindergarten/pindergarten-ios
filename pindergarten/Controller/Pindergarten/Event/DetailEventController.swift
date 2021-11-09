//
//  DetailEventController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/02.
//

import UIKit
import Kingfisher

class DetailEventController: BaseViewController {
    //MARK: - Properties
    
    var id: Int = 0
    var eventComment: [GetEventCommentResult] = []
    
    lazy var getDetailEventDataManager: GetDetailEventDataManager = GetDetailEventDataManager()
    lazy var likeEventDataManager: EventLikeDataManager = EventLikeDataManager()
    lazy var getEventCommentDataManager: GetEventCommentDataManager = GetEventCommentDataManager()
    
    
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
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.numberOfLines = 0
        label.textColor = .mainTextColor
        label.text = "이벤트 제목"
        return label
    }()
    
    let eventImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "2")
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()

    private let eventImageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let dDayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.95
        view.layer.applyShadow(color: .black, alpha: 0.4, x: 1, y: 3, blur: 7)
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 25
        return view
    }()
    
    let dDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = UIColor(hex: 0x3D3D3D)
        label.text = "D-23"
        return label
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
        label.text = "294"
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "commentImage"), for: .normal)
        button.addTarget(self, action: #selector(goToCommentVC), for: .touchUpInside)
        return button
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x858585)
        label.text = "294"
        return label
    }()
    
    private let commentSeperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xEAEAEA)
        return view
    }()
    
    private lazy var commentTextButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.backgroundColor = .mainLightYellow
        button.addTarget(self, action: #selector(goToCommentVC), for: .touchUpInside)
        return button
    }()
    
    private let commentPlaceHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글을 입력하세요 :)"
        label.textColor = UIColor(hex: 0x7E7E7E, alpha: 0.8)
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        return label
    }()
    
    private let commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetailEventDataManager.getADetailEvent(eventId: id, delegate: self)
        getEventCommentDataManager.getEventComment(eventId: id, delegate: self)
        
        commentTableView.estimatedRowHeight = 150
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getEventCommentDataManager.getEventComment(eventId: id, delegate: self)
    }
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func goToCommentVC() {
        let commentVC = EventCommentController()
        commentVC.eventId = self.id
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    @objc private func didTapHeartButton() {
        likeEventDataManager.likeEvent(eventId: id, delegate: self)
    }
    
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(seperateLine)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(eventNameLabel)
        containerView.addSubview(eventImage)
        containerView.addSubview(dDayView)
        dDayView.addSubview(dDayLabel)
        containerView.addSubview(heartButton)
        containerView.addSubview(heartLabel)
        containerView.addSubview(commentButton)
        containerView.addSubview(commentLabel)
        containerView.addSubview(commentTableView)
        view.addSubview(commentSeperateLine)
        view.addSubview(commentTextButton)
        commentTextButton.addSubview(commentPlaceHolderLabel)

        
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
            make.bottom.equalTo(commentSeperateLine.snp.top)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView)
        }
        
        
        eventNameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(20)
            make.left.equalTo(view).offset(20)
        }
        
        eventImage.snp.makeConstraints { make in
            make.top.equalTo(eventNameLabel.snp.bottom).offset(8)
            make.width.height.equalTo(Device.width - 40)
            make.centerX.equalTo(view)
        }
        
        dDayView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.equalTo(eventImage).offset(10)
            make.right.equalTo(eventImage).offset(-10)
        }
        
        dDayLabel.snp.makeConstraints { make in
            make.center.equalTo(dDayView)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(eventImage.snp.bottom).offset(15)
            make.left.equalTo(view).offset(20)
            make.width.height.equalTo(25)
        }
        
        heartLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.left.equalTo(heartButton.snp.right).offset(6)
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
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.bottom)
            make.left.right.equalTo(containerView)
            make.bottom.equalTo(containerView)
        }
        
        commentSeperateLine.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.left.right.equalTo(view)
            make.bottom.equalTo(commentTextButton.snp.top).offset(-10)
        }
        
        commentTextButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-10)
            make.height.equalTo(40)
        }
        
        commentPlaceHolderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(commentTextButton)
            make.left.equalTo(commentTextButton).offset(16)
        }
    }
}

//MARK: - Extension
extension DetailEventController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        cell.selectionStyle = .none
        
        cell.profileImage.kf.setImage(with: URL(string: eventComment[indexPath.item].profileimg))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        let attributedString = NSMutableAttributedString(string: "\(eventComment[indexPath.item].nickname)  ", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!, .foregroundColor : UIColor(hex: 0x2D2D2D, alpha: 0.85), .paragraphStyle : paragraphStyle])
        attributedString.append(NSAttributedString(string: eventComment[indexPath.item].content, attributes: [.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!, .foregroundColor : UIColor(hex: 0x4E5261, alpha: 0.85), .paragraphStyle : paragraphStyle]))
        cell.commentLabel.attributedText = attributedString
        
        cell.timeLabel.text = eventComment[indexPath.item].date
        cell.commentId = eventComment[indexPath.item].id
        cell.userId = eventComment[indexPath.item].userId

        return cell
    }
    
    
}

// 네트워크 함수
extension DetailEventController {
    func didSuccessGetDetailEvent(_ result: GetDetailEventResult) {
        print("DEBUG: GET DETAIL EVENT")
        eventNameLabel.text = result.title
        eventImage.kf.setImage(with: URL(string: result.thumbnail))
        result.isLiked == 0 ? heartButton.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal) : heartButton.setImage(#imageLiteral(resourceName: "feedFilledHeartImage"), for: .normal)
        heartLabel.text = "\(result.likeCount)"
        commentLabel.text = "\(result.commentCount)"
        
    }
    
    func failedToGetDetailEvent(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED TO GET DETAIL EVENT")
    }
    
    func didSuccessLikeEvent(_ result: EventLikeResult) {
        print("DEBUG: LIKE EVENT")
        if result.isSet == 0 {
            heartButton.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
            heartLabel.text = "\(Int(heartLabel.text!)!-1)"
        } else {
            heartButton.setImage(#imageLiteral(resourceName: "feedFilledHeartImage"), for: .normal)
            heartLabel.text = "\(Int(heartLabel.text!)!+1)"
        }
        
    }
    
    func failedToLikeEvent(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED TO LIKE EVENT")
    }
    
    func didSuccessGetEventComment(_ result: [GetEventCommentResult]) {
        eventComment = result
        commentTableView.reloadData()
    }
    
    func failedToGetEventComment(message: String) {
        self.presentAlert(title: message)
    }
}

