//
//  DetailTimePindergartenInfoCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/26.
//

import UIKit

class DetailTimePindergartenInfoCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "DetailTimePindergartenInfoCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = .mainTextColor
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = .subTextColor
        label.text = "-"
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(28)
            make.left.right.equalTo(contentView).inset(20)
        }
      
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(contentView).offset(-18)
        }

    }
}

