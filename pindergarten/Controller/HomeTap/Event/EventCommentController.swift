//
//  EventCommentController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/04.
//

import UIKit

class EventCommentController: BaseViewController {
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //MARK: - Properties
    
    lazy var getEventCommentDataManager: GetEventCommentDataManager = GetEventCommentDataManager()
    lazy var registerCommentDataManager: PostEventCommentDataManager = PostEventCommentDataManager()
    lazy var deleteEventCommentDataManager: DeleteEventCommentDataManager = DeleteEventCommentDataManager()

    var eventId: Int = 0
    var eventComment: [GetEventCommentResult] = []
    var keyboardHeight: CGFloat = 0
    var isPaginating: Bool = false
    private var lastContentOffset: CGFloat = 0
    

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
        label.text = "댓글"
        label.textColor = .mainTextColor
        return label
    }()

    private let seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()

    private let commentSeperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xEAEAEA)
        return view
    }()

    private lazy var commentTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        tf.textColor = UIColor(hex: 0x4E5261)
        tf.attributedPlaceholder = NSAttributedString(string: "댓글을 입력하세요 :)", attributes: [.foregroundColor:UIColor(hex: 0x7E7E7E, alpha: 0.8), .font:UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!])
        let spacer = UIView()
        let spacerRight = UIView()
        spacer.setDimensions(height: 40, width: 16)
        spacerRight.setDimensions(height: 40, width: 16)
        tf.leftView = spacer
        tf.rightView = spacerRight
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.borderStyle = .none
        tf.layer.cornerRadius = 20
        tf.backgroundColor = .mainLightYellow
        tf.autocorrectionType = .no
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return tf
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "등록", attributes: [.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!]), for: .normal)
        button.tintColor = UIColor(hex: 0x777777)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        return button
    }()

    private let commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
//        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()


        getEventCommentDataManager.getEventComment(eventId: eventId, delegate: self)
        
        commentTableView.estimatedRowHeight = 150
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)

        commentTextField.becomeFirstResponder()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)



        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)


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

    @objc private func didTapRegisterButton() {
        registerCommentDataManager.registerComment(eventId: eventId, PostEventCommentRequest(content: commentTextField.text ?? ""), delegate: self)
        commentTextField.text = ""
        registerButton.tintColor = UIColor(hex: 0x4E5261)
        registerButton.isUserInteractionEnabled = false
//        self.view.endEditing(false)
    }

    @objc func keyboardWillShow(_ sender: Notification) {

        let userInfo:NSDictionary = sender.userInfo! as NSDictionary;
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.size.height

        commentTextField.snp.remakeConstraints { remake in
            remake.left.equalTo(view).offset(20)
            remake.right.equalTo(view).offset(-62)
            remake.bottom.equalTo(view.snp.bottom).offset(-10-keyboardHeight)
            remake.height.equalTo(40)
        }
        
//        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut) {
//            self.view.layoutIfNeeded()
//        } completion: { _ in
//            let indexPath = IndexPath(item: (self?.eventComment.count ?? 1) - 1 , section: 0)
//            self?.commentTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//        }

       
        
    }

    @objc func keyboardWillHide(_ sender: Notification) {
       
        
        commentTextField.snp.remakeConstraints { remake in
            remake.left.equalTo(view).offset(20)
            remake.right.equalTo(view).offset(-62)
            remake.bottom.equalTo(view.snp.bottomMargin).offset(-10)
            remake.height.equalTo(40)
        }
    }

    @objc func textFieldDidChange(_ sender: Any?) {
        checkCommentTF()
    }
    //MARK: - Helpers

    private func checkCommentTF() {
        if commentTextField.text?.count ?? 0 <= 0 {
            registerButton.tintColor = UIColor(hex: 0x4E5261)
            registerButton.isUserInteractionEnabled = false
        } else {
            registerButton.tintColor = .mainBrown
            registerButton.isUserInteractionEnabled = true
        }
    }

    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(seperateLine)
        view.addSubview(commentTableView)
        view.addSubview(commentSeperateLine)
        view.addSubview(commentTextField)
        view.addSubview(registerButton)
        view.addSubview(commentTableView)

        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalTo(view)
        }

        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }

        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(commentSeperateLine.snp.top)
        }

        commentSeperateLine.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.left.right.equalTo(view)
            make.bottom.equalTo(commentTextField.snp.top).offset(-10)
        }

        commentTextField.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-62)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-10)
            make.height.equalTo(40)
        }

        registerButton.snp.makeConstraints { make in
            make.left.equalTo(commentTextField.snp.right).offset(17)
            make.centerY.equalTo(commentTextField)
            make.width.equalTo(25)
            make.height.equalTo(40)
        }
    }
}

//MARK: - Extension
extension EventCommentController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventComment.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        cell.selectionStyle = .none
        cell.delegate = self

        cell.profileImage.kf.setImage(with: URL(string: eventComment[indexPath.item].profileimg))

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        let attributedString = NSMutableAttributedString(string: "\(eventComment[indexPath.item].nickname)  ", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!, .foregroundColor : UIColor(hex: 0x2D2D2D, alpha: 0.85), .paragraphStyle : paragraphStyle])
        attributedString.append(NSAttributedString(string: eventComment[indexPath.item].content, attributes: [.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!, .foregroundColor : UIColor(hex: 0x4E5261, alpha: 0.85), .paragraphStyle : paragraphStyle]))
        cell.commentLabel.attributedText = attributedString
        cell.timeLabel.text = eventComment[indexPath.item].date
        cell.commentId = eventComment[indexPath.item].id
        cell.userId = eventComment[indexPath.item].userId
        
        return cell
    }
    
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.y // frame영역의 origin에 비교했을때의 content view의 현재 origin 위치
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height // 화면에는 frame만큼 가득 찰 수 있기때문에 frame의 height를 빼준 것
//
//        // 스크롤 할 수 있는 영역보다 더 스크롤된 경우 (하단에서 스크롤이 더 된 경우)
//        if maximumOffset < currentOffset - 50 {
//            // viewModel.loadNextPage()
//            isPaginating = true
//            print(10)
//            self.commentTableView.tableFooterView = createSpinnerFooter()
//            getEventCommentDataManager.getEventComment(eventId: eventId, delegate: self)
//        }
//    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(self.lastContentOffset - scrollView.contentOffset.y)
//        if (self.lastContentOffset - scrollView.contentOffset.y > 0) {
//            self.view.endEditing(false)
//
//        }
//        // update the new position acquired
//        self.lastContentOffset = scrollView.contentOffset.y
//    }
    
}

extension EventCommentController: CommentCellDelegate  {
    func didTapUserProfile(userId: Int) {
        print("tap \(userId)")
        let userVC = UserPageController()
        userVC.userId = userId
        navigationController?.pushViewController(userVC, animated: true)
    }
    
    func didLongPressComment(commentId: Int, userId: Int) {

        if JwtToken.userId == userId {
             let actionDelete = UIAlertAction(title: "댓글 삭제하기", style: .destructive) { action in
                self.deleteEventCommentDataManager.deleteComment(eventId: self.eventId, commentId: commentId, delegate: self)
             }

             let actionCancel = UIAlertAction(title: "취소", style: .cancel) { action in
             }

             self.presentAlert(
                 preferredStyle: .actionSheet,
                 with: actionDelete, actionCancel
             )
        } else {
            let actionDelete = UIAlertAction(title: "신고하기", style: .destructive) { action in
             
            }

            let actionCancel = UIAlertAction(title: "취소", style: .cancel) { action in
            }

            self.presentAlert(
                preferredStyle: .actionSheet,
                with: actionDelete, actionCancel
            )
        }
    }
}



// 네트워크 함수
extension EventCommentController {
    
    func didSuccessGetEventComment(_ result: [GetEventCommentResult]) {
        self.commentTableView.tableFooterView = nil
        eventComment = result
        commentTableView.reloadData()
        if eventComment.count > 0 && !isPaginating {
            let indexPath = IndexPath(item: eventComment.count - 1 , section: 0)
            commentTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
      
        
    }
    
    func failedToGetEventComment(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessRegisterComment() {
        isPaginating = false
        getEventCommentDataManager.getEventComment(eventId: eventId, delegate: self)
        
    }
    
    func failedToRegisterComment(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessDeleteComment() {
        isPaginating = true
        getEventCommentDataManager.getEventComment(eventId: eventId, delegate: self)
    }
    
    func failedToDeleteComment(message: String) {
        self.presentAlert(title: message)
    }
    
}

