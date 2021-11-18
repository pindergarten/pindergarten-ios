//
//  EventCommentController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/02.
//

import UIKit

class CommentController: BaseViewController {
    //MARK: - Properties
    
    lazy var getCommentDataManager: GetCommentDataManager = GetCommentDataManager()
    lazy var registerCommentDataManager: PostCommentDataManager = PostCommentDataManager()
    lazy var deleteCommentDataManager: DeleteCommentDataManager = DeleteCommentDataManager()
    
    var postId: Int = 0
    private var comments: [GetCommentResult] = []
    
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
    
    private lazy var commentTextFeild: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        tf.textColor = UIColor(hex: 0x4E5261)
        tf.attributedPlaceholder = NSAttributedString(string: "댓글을 입력하세요 :)", attributes: [.foregroundColor:UIColor(hex: 0x7E7E7E, alpha: 0.8), .font:UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!])
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 16)
        tf.leftView = spacer
        tf.leftViewMode = .always
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
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCommentDataManager.getComment(postId: postId, delegate: self)
        
        
        commentTableView.estimatedRowHeight = 150
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        
        commentTextFeild.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        configureUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapRegisterButton() {
        registerCommentDataManager.registerComment(postId: postId, PostCommentRequest(content: commentTextFeild.text ?? ""), delegate: self)
        commentTextFeild.text = ""
        registerButton.tintColor = UIColor(hex: 0x4E5261)
        registerButton.isUserInteractionEnabled = false
        self.view.endEditing(false)
        print("DEBUG: TAPPED REGISTER BUTTON")
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary;
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.size.height
        
        
        commentTextFeild.snp.remakeConstraints { remake in
            remake.left.equalTo(view).offset(20)
            remake.right.equalTo(view).offset(-62)
            remake.bottom.equalTo(view.snp.bottom).offset(-10-keyboardHeight)
            remake.height.equalTo(40)
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        commentTextFeild.snp.remakeConstraints { remake in
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
        if commentTextFeild.text?.count ?? 0 <= 0 {
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
        view.addSubview(commentTextFeild)
        view.addSubview(registerButton)
        
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
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(commentSeperateLine)
        }
        
        commentSeperateLine.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.left.right.equalTo(view)
            make.bottom.equalTo(commentTextFeild.snp.top).offset(-10)
        }
        
        commentTextFeild.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-62)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-10)
            make.height.equalTo(40)
        }
        
        registerButton.snp.makeConstraints { make in
            make.left.equalTo(commentTextFeild.snp.right).offset(17)
            make.centerY.equalTo(commentTextFeild)
            make.width.equalTo(25)
            make.height.equalTo(40)
        }
    }
}

//MARK: - Extension
extension CommentController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.profileImage.kf.setImage(with: URL(string: comments[indexPath.item].profileimg))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        let attributedString = NSMutableAttributedString(string: "\(comments[indexPath.item].nickname)  ", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!, .foregroundColor : UIColor(hex: 0x2D2D2D, alpha: 0.85), .paragraphStyle : paragraphStyle])
        attributedString.append(NSAttributedString(string: comments[indexPath.item].content, attributes: [.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!, .foregroundColor : UIColor(hex: 0x4E5261, alpha: 0.85), .paragraphStyle : paragraphStyle]))
        cell.commentLabel.attributedText = attributedString
        
        cell.timeLabel.text = comments[indexPath.item].date
        cell.commentId = comments[indexPath.item].id
        cell.userId = comments[indexPath.item].userId

        return cell
    }

}

extension CommentController: CommentDelegate {
    func didTapCommentButton() {
        let commentVC = CommentController()
        commentVC.postId = self.postId
        navigationController?.pushViewController(commentVC, animated: true)
    }
}
extension CommentController: CommentCellDelegate {

    func didLongPressComment(commentId: Int, userId: Int) {
        print(commentId)
        print(userId)
        if JwtToken.userId == userId {
             let actionDelete = UIAlertAction(title: "댓글 삭제하기", style: .destructive) { action in
                self.deleteCommentDataManager.deleteComment(postId: self.postId, commentId: commentId, delegate: self)
             }

             let actionCancel = UIAlertAction(title: "취소하기", style: .default) { action in
             }

             self.presentAlert(
                 preferredStyle: .actionSheet,
                 with: actionDelete, actionCancel
             )
        }
    }
}

// 네트워크 함수
extension CommentController {
    func didSuccessGetComment(_ result: [GetCommentResult]) {
        comments = result
        commentTableView.reloadData()
    }
    
    func failedToGetComment(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessRegisterComment() {
        getCommentDataManager.getComment(postId: postId, delegate: self)
    }
    
    func failedToRegisterComment(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessDeleteComment() {
        getCommentDataManager.getComment(postId: postId, delegate: self)
    }
    
    func failedToDeleteComment(message: String) {
        self.presentAlert(title: message)
    }
    
    
}
