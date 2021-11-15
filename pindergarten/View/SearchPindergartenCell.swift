//
//  SearchPindergartenCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import UIKit

class SearchPindergartenCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "SearchPindergartenCell"
    
    private let positionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "position")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = .mainTextColor
        label.text = "하울팟 케어클럽 서초본점"
        label.numberOfLines = 1
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        label.textColor = UIColor(hex: 0xC1C1C1)
        label.text = "서울특별시 서초구 서초대로58길 36 4~5F"
        label.numberOfLines = 1
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

        contentView.addSubview(positionImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)

        positionImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.left.equalTo(contentView).offset(28)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(positionImage)
            make.left.equalTo(positionImage.snp.right).offset(15)
            make.right.equalTo(contentView).offset(-47)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalTo(nameLabel)
            make.right.equalTo(nameLabel)
            make.bottom.equalTo(contentView).offset(-12)
        }
    }
}

