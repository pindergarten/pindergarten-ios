//
//  CommentCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import UIKit

class CommentCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "CommentCell"
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "4")
        imageView.layer.cornerRadius = 17
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
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
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        let attributedString = NSMutableAttributedString(string: "oneoneni  ", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!, .foregroundColor : UIColor(hex: 0x2D2D2D, alpha: 0.85), .paragraphStyle : paragraphStyle])
        attributedString.append(NSAttributedString(string: "장치 꼬미네용 ㅎㅎ 저희도 장치꼬미인데!! 반가워용 ㅎㅎㅎ장치 꼬미네용 ㅎㅎ 저희도 장치꼬미인데!! 반가워용 ㅎㅎㅎ장치 꼬미네용 ㅎㅎ 저희도 장치꼬미인데!! 반가워용 ㅎㅎㅎ장치 꼬미네용 ㅎㅎ 저희도 장치꼬미인데!! 반가워용 ㅎㅎㅎ장치 꼬미네용 ㅎㅎ 저희도 장치꼬미인데!! 반가워용 ㅎㅎㅎ장치 꼬미네용 ㅎㅎ 저희도 장치꼬미인데!! 반가워용 ㅎㅎㅎ", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!, .foregroundColor : UIColor(hex: 0x4E5261, alpha: 0.85), .paragraphStyle : paragraphStyle]))
        label.attributedText = attributedString
        return label
    }()

    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        label.textColor = UIColor(hex: 0xA1A1A1)
        label.text = " 2021-10-12 16:46"
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    
    //MARK: - Helpers
    private func configureUI() {
        backgroundColor = .white
        
        addSubview(profileImage)
//        addSubview(nameLabel)
        addSubview(commentLabel)
        addSubview(timeLabel)
        
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(20)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage)
            make.left.equalTo(profileImage.snp.right).offset(8)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(timeLabel.snp.top).offset(-4)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(commentLabel)
            make.bottom.equalTo(self).offset(-20)
        }
        
    }
}
