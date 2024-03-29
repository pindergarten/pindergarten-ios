//
//  DetailFeedCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import UIKit
import ImageSlideshow

//MARK: - Protocol
protocol DetailFeedCellDelegate: AnyObject {
    func didTapHeartButton()
}

protocol CommentDelegate: AnyObject {
    func didTapCommentButton()
}


class DetailFeedCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "DetailFeedCell"
    weak var delegate: DetailFeedCellDelegate?
    weak var commentDelegate: CommentDelegate?
    
    let images = [
        ImageSource(image: #imageLiteral(resourceName: "4")),
        ImageSource(image: #imageLiteral(resourceName: "4")),
        ImageSource(image: #imageLiteral(resourceName: "4")),
        ImageSource(image: #imageLiteral(resourceName: "4"))
//        AlamofireSource(urlString: "https://firebasestorage.googleapis.com/v0/b/pindergarten-2c814.appspot.com/o/Posts%2Funsplash_G8cB8hY3yvU.png?alt=media&token=1070c9b6-e524-4a5d-b198-241e779f9ca0", placeholder: #imageLiteral(resourceName: "4")),
//        AlamofireSource(urlString: "https://firebasestorage.googleapis.com/v0/b/pindergarten-2c814.appspot.com/o/Posts%2Funsplash_G8cB8hY3yvU.png?alt=media&token=1070c9b6-e524-4a5d-b198-241e779f9ca0", placeholder: #imageLiteral(resourceName: "4"))
    ]

    
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
        return button
    }()

    
    var imageSlide = ImageSlideshow()
    
    lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "feedFilledHeartImage"), for: .selected)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    let heartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x858585)
        label.text = "0"
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
        label.text = "0"
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
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(hex: 0x858585)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        label.attributedText = NSMutableAttributedString(string: "잔디에 누워서 한컷~!\n오전에 추워서 긴팔입고 나갔더니 덥네요 ㅜㅜ", attributes: [.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "더보기", attributes: [.font :  UIFont(name: "AppleSDGothicNeo-Regular", size: 11)!]), for: .normal)
        button.tintColor = UIColor(hex: 0x858585, alpha: 0.5)
        return button
    }()
    
    let moreLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "더보기", attributes: [.font :  UIFont(name: "AppleSDGothicNeo-Regular", size: 11)!])
        label.textColor = UIColor(hex: 0x858585, alpha: 0.5)
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
        
//        imageSlide.setImageInputs(images)
        imageSlide.contentMode = .scaleToFill
        imageSlide.circular = false
        
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    @objc func didTapHeartButton(isSet: Int) {
        delegate?.didTapHeartButton()
        print("DEBUG: TAPPED HEART BUTTON")
        if isSet == 0 {
            heartButton.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
        } else {
            heartButton.setImage(#imageLiteral(resourceName: "feedFilledHeartImage"), for: .normal)
        }
    }
    
    @objc func didTapCommentButton() {
        commentDelegate?.didTapCommentButton()
        print("DEBUG: TAPPED COMMENT BUTTON")
    }
    //MARK: - Helpers
    private func configureUI() {
        backgroundColor = .white
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(menuButton)
        contentView.addSubview(imageSlide)
        contentView.addSubview(heartButton)
        contentView.addSubview(heartLabel)
        contentView.addSubview(commentButton)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(contentLabel)
//        addSubview(moreButton)
        contentView.addSubview(moreLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(20)
            make.width.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(6)
        }
        
        menuButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.right.equalTo(contentView).offset(-10)
            make.height.width.equalTo(30)
        }
        
        imageSlide.snp.makeConstraints { make in
            make.width.height.equalTo(Device.width)
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(imageSlide.snp.bottom).offset(15)
            make.left.equalTo(contentView).offset(20)
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
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.right.equalTo(contentView).offset(-20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-16)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-57)
            make.height.equalTo(40)
        }
        
        moreLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(contentLabel.snp.bottom)
        }
    }
}
