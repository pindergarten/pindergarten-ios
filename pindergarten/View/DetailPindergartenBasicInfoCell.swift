//
//  DetailPindergartenBasicInfoCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import UIKit

class DetailPindergartenBasicInfoCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "DetailPindergartenBasicInfoCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = .mainTextColor
        label.text = "기본정보"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let callLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x515151)
        label.text = "전화"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x515151)
        label.text = "주소"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let homepageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x515151)
        label.text = "홈페이지"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
//    let socialLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
//        label.textColor = UIColor(hex: 0x515151)
//        label.text = "소셜"
//        return label
//    }()
    
    let callInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = .subTextColor
        label.text = "050-7148-71108"
        return label
    }()
    
    let addressInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = .subTextColor
        label.text = "서울 서초구 서초대로 58길 36 4~5F"
        return label
    }()
    
    let homepageInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = .subTextColor
        label.text = "https://www.howlpot.com"
        return label
    }()
    
    let socialInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = .subTextColor
        label.text = "http://blog.naver.com/howlpotcareclub"
        return label
    }()
    
    private let separateLine: UIView = {
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(callLabel)
        contentView.addSubview(callInfoLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(addressInfoLabel)
        contentView.addSubview(homepageLabel)
        contentView.addSubview(homepageInfoLabel)
//        contentView.addSubview(socialLabel)
//        contentView.addSubview(socialInfoLabel)
        contentView.addSubview(separateLine)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        callLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.left.equalTo(contentView).offset(20)
            make.width.equalTo(52)
        }
        
        callInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(callLabel)
            make.left.equalTo(callLabel.snp.right).offset(26)
            
            make.right.equalTo(contentView).offset(-20)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(callInfoLabel.snp.bottom).offset(18)
            make.left.equalTo(callLabel)
            make.width.equalTo(52)
        }
        
        addressInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel)
            make.left.equalTo(callInfoLabel.snp.left)
            make.right.equalTo(contentView).offset(-20)
        }
        
        homepageLabel.snp.makeConstraints { make in
            make.top.equalTo(addressInfoLabel.snp.bottom).offset(18)
            make.left.equalTo(callLabel)
            make.width.equalTo(52)
        }
        
        homepageInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(homepageLabel)
            make.left.equalTo(callInfoLabel.snp.left)
            make.right.equalTo(contentView).offset(-20)
        }
        
//        socialLabel.snp.makeConstraints { make in
//            make.top.equalTo(homepageInfoLabel.snp.bottom).offset(18)
//            make.left.equalTo(callLabel)
//            make.width.equalTo(52)
//        }
//
//        socialInfoLabel.snp.makeConstraints { make in
//            make.top.equalTo(socialLabel)
//            make.left.equalTo(callInfoLabel.snp.left)
//            make.right.equalTo(contentView)
//        }
        
        separateLine.snp.makeConstraints { make in
            make.top.equalTo(homepageInfoLabel.snp.bottom).offset(22)
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(6)
        }
        
    
    }
}
