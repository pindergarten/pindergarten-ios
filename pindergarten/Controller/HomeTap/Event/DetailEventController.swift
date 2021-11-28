//
//  DetailEventController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/02.
//

import UIKit
import Kingfisher

class DetailEventController: BaseViewController {
    deinit {
            print("deinit")
    }
    //MARK: - Properties
    
    var id: Int = 0
    var dday: Int = 0
    var eventComment: [GetEventCommentResult] = []
    
    lazy var getDetailEventDataManager: GetDetailEventDataManager = GetDetailEventDataManager()
    lazy var likeEventDataManager: EventLikeDataManager = EventLikeDataManager()
    lazy var getEventCommentDataManager: GetEventCommentDataManager = GetEventCommentDataManager()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let commentSeparateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xEAEAEA)
        return view
    }()
    
    private lazy var commentTextButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.backgroundColor = .mainLightYellow
        button.addTarget(self, action: #selector(didTapCommentTextButton), for: .touchUpInside)
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
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return tableView
    }()
    
    let headerView = EventHeaderView()
    let footerView = EventFooterView(frame: CGRect(x: 0, y: 0, width: Device.width, height: 30))
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        commentTableView.tableFooterView = footerView
        
        if self.dday == 0 {
            headerView.dDayLabel.text = "D-DAY"
        } else {
            headerView.dDayLabel.text = "D-\(self.dday)"
        }
        
        
        
        headerView.delegate = self
        footerView.delegate = self
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = size.height
        let width = size.width
        size.width = UIScreen.main.bounds.width
        headerView.frame = CGRect(x: 0, y: 0, width: width, height: height)
//        headerView.frame.size = size
        
//        size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//        size.width = UIScreen.main.bounds.width
//        headerView.frame.size = size
        
        commentTableView.tableHeaderView = headerView
        getDetailEventDataManager.getADetailEvent(eventId: id, delegate: self)
        getEventCommentDataManager.getEventComment(eventId: id, delegate: self)

        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.estimatedRowHeight = UITableView.automaticDimension
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
    
    @objc private func didTapCommentTextButton() {
        let commentVC = EventCommentController()
        commentVC.eventId = self.id
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(separateLine)
        view.addSubview(commentTableView)
        view.addSubview(commentSeparateLine)
        view.addSubview(commentTextButton)
        commentTextButton.addSubview(commentPlaceHolderLabel)

        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        separateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }

        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(commentSeparateLine.snp.top).offset(-14)
        }
        
        commentSeparateLine.snp.makeConstraints { make in
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
        return eventComment.count == 0 ? 0 : 3
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

extension DetailEventController: EventHeaderDelegate {
    func goToCommentVC() {
        let commentVC = EventCommentController()
        commentVC.eventId = self.id
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    func didTapHeartButton() {
        likeEventDataManager.likeEvent(eventId: id, delegate: self)
    }
}

extension DetailEventController: EventFooterDelegate {
    func didTapMoreCommentButton() {
        let commentVC = EventCommentController()
        commentVC.eventId = self.id
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    
}

// 네트워크 함수
extension DetailEventController {
    func didSuccessGetDetailEvent(_ result: GetDetailEventResult) {
        headerView.eventNameLabel.text = result.title
        headerView.eventImage.kf.indicatorType = .activity
        headerView.eventImage.kf.setImage(with: URL(string: result.image), placeholder: nil, options: [.transition(.fade(0.7)), .loadDiskFileSynchronously], progressBlock: nil)
        
        result.isLiked == 0 ? headerView.heartButton.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal) : headerView.heartButton.setImage(#imageLiteral(resourceName: "feedFilledHeartImage"), for: .normal)
        headerView.heartLabel.text = "\(result.likeCount)"
        headerView.commentLabel.text = "\(result.commentCount)"

    }

    func failedToGetDetailEvent(message: String) {
        self.presentAlert(title: message)
        print("DEBUG: FAILED TO GET DETAIL EVENT")
    }

    func didSuccessLikeEvent(_ result: EventLikeResult) {
        print("DEBUG: LIKE EVENT")
        if result.isSet == 0 {
            headerView.heartButton.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
            headerView.heartLabel.text = "\(Int(headerView.heartLabel.text!)!-1)"
        } else {
            headerView.heartButton.setImage(#imageLiteral(resourceName: "feedFilledHeartImage"), for: .normal)
            headerView.heartLabel.text = "\(Int(headerView.heartLabel.text!)!+1)"
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

