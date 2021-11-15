//
//  DetailPindergartenInfoCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import UIKit

class DetailPindergartenInfoCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "DetailPindergartenInfoCell"
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = .mainTextColor
        label.text = "영업시간"
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = .subTextColor
        label.text = "10:30 - 20:00 연중무휴"
        return label
    }()
    
    private let line: UIView = {
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
        contentView.addSubview(infoLabel)
//        contentView.addSubview(line)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(contentView).offset(-18)
        }
        
//        line.snp.makeConstraints { make in
//            make.top.equalTo(infoLabel.snp.bottom).offset(18)
//            make.left.equalTo(contentView).offset(20)
//            make.right.equalTo(contentView).offset(-20)
//            make.bottom.equalTo(contentView)
//            make.height.equalTo(1)
//
//        }
    }
}
