//
//  DetailPindergartenBlogReviewCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import UIKit

class DetailPindergartenBlogReviewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "DetailPindergartenBlogReviewCell"

    let blogTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = .subTextColor
        label.text = "강아지유치원 다녀온 동구 @하울팟케어클럽"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = .subTextColor
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
        label.attributedText = NSMutableAttributedString(string: "평소에는 거의 떨어질 일 없이 저와 함께 다니는 동구인데 워낙 에너지가 넘치는 댕댕이라 친구들과 시간을 보내는 것도 좋을 것 같아서 강아지 유치원 체험을 해보았어요 .....", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        label.textColor = UIColor(hex: 0xB0B0B0)
        label.text = "2021-03-17"
        return label
    }()
    
    let goToBlogLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        label.textColor = UIColor(hex: 0xB0B0B0)
        label.text = "네이버 블로그"
        return label
    }()
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE9E9E9)
        return view
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
       
        contentView.addSubview(blogTitleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(goToBlogLabel)
//        contentView.addSubview(line)
       
        
        blogTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(18)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(blogTitleLabel.snp.bottom).offset(5)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(20)
        }
        
        goToBlogLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(contentView).offset(-18)
        }
        
//        line.snp.makeConstraints { make in
//            make.top.equalTo(goToBlogLabel.snp.bottom).offset(18)
//            make.left.equalTo(contentView).offset(20)
//            make.right.equalTo(contentView).offset(-20)
//            make.bottom.equalTo(contentView)
//            make.height.equalTo(1)
//
//        }
    }
}
