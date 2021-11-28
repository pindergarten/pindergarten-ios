//
//  CommentCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import UIKit

protocol CommentCellDelegate: AnyObject {
    func didLongPressComment(commentId: Int, userId: Int)
}

class CommentCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "CommentCell"
    var commentId: Int = 0
    var userId: Int = 0
    
    weak var delegate: CommentCellDelegate?
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "4")
        imageView.layer.cornerRadius = 17
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        label.textColor = UIColor(hex: 0x2D2D2D, alpha: 0.85)
        label.text = "oneoneni"
        return label
    }()

//    private let commentLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
//        label.textColor = UIColor(hex: 0x4E5261, alpha: 0.85)
//        label.text = "장치 꼬미네용 ㅎㅎ 저희도 장치꼬미인데!! 반가워용 ㅎㅎㅎ"
//        return label
//    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        label.textColor = UIColor(hex: 0xA1A1A1)
        label.text = " 2021-10-12 16:46"
        return label
    }()
    
    private lazy var commentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [commentLabel, timeLabel])
        stack.axis = .vertical
        stack.spacing = 3
        return stack
    }()
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        putGesture()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    @objc private func didLongPressComment(_ gesture: UILongPressGestureRecognizer) {
        print("DEBUG: LONG PRESS")
        delegate?.didLongPressComment(commentId: self.commentId, userId: self.userId)
    }
    //MARK: - Helpers
    private func putGesture() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressComment(_:)))
        gestureRecognizer.numberOfTouchesRequired = 1
        gestureRecognizer.numberOfTapsRequired = 0
        addGestureRecognizer(gestureRecognizer)
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        contentView.addSubview(profileImage)
//        addSubview(nameLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(timeLabel)
//        contentView.addSubview(commentStack)

        
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(20)
        }
        
//        commentStack.snp.makeConstraints { make in
//            make.centerY.equalTo(profileImage).offset(-1)
//            make.left.equalTo(profileImage.snp.right).offset(8)
//            make.right.equalTo(contentView).inset(20)
//
//        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage)
            make.left.equalTo(profileImage.snp.right).offset(8)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(timeLabel.snp.top).offset(-4)
        }

        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(commentLabel)
            make.bottom.equalTo(contentView).offset(-5)
        }
        
    }
}
