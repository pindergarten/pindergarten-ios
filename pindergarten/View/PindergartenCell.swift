//
//  PindergartenCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/12.
//

import UIKit
import Cosmos

protocol PindergartenCellDelegate: AnyObject {
    func didTapCellHeartButton(index: Int)
}


class PindergartenCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "PindergartenCell"
    weak var delegate: PindergartenCellDelegate?
    
    let pindergartenImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = #imageLiteral(resourceName: "1")
        return imageView
    }()
    
    let distanceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x2B2B2B, alpha: 0.56)
        view.layer.applyShadow(color: UIColor(hex: 0x000000), alpha: 0.1, x: 0, y: 4, blur: 4)
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.layer.shouldRasterize = true
        return view
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        label.text = "0km"
        label.textColor = .white
        return label
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
        label.textColor = UIColor(hex: 0x4E5261)
        label.text = "서울특별시 서초구 서초대로58길 36 4~5F"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pcellHeart"), for: .normal)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        label.textColor = UIColor(hex: 0x4E5261)
        label.text = "0/5"
        return label
    }()
    
    let starView: CosmosView = {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.fillMode = .precise
        view.settings.starSize = 12
        view.settings.starMargin = 2
        view.settings.filledImage = UIImage(named: "filledStar")
        view.settings.emptyImage = UIImage(named: "star")
        view.rating = 4.4
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
    @objc private func didTapHeartButton(index: Int) {
        delegate?.didTapCellHeartButton(index: heartButton.tag)
    }
    //MARK: - Helpers
    private func configureUI() {
        contentView.addSubview(pindergartenImage)
        contentView.addSubview(distanceView)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(heartButton)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(starView)
        
        
        pindergartenImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(134)
        }
        
        distanceView.snp.makeConstraints { make in
            make.top.right.equalTo(pindergartenImage).inset(12)
            make.height.equalTo(20)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.center.equalTo(distanceView)
            make.left.equalTo(distanceView).offset(10)
            make.right.equalTo(distanceView).offset(-10)
        }
    
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(pindergartenImage.snp.bottom).offset(10)
            make.left.equalTo(contentView)
            make.right.equalTo(heartButton.snp.left).offset(-20)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(contentView)
            make.right.equalTo(heartButton.snp.left).offset(-20)
        }
        
        heartButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.equalTo(pindergartenImage.snp.bottom).offset(0)
            make.right.equalTo(contentView)
        }
        contentView.bringSubviewToFront(heartButton)
        
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView)
            make.top.equalTo(addressLabel.snp.bottom).offset(4)
            make.bottom.equalTo(contentView).offset(-20)
        }
        
        starView.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel)
            make.left.equalTo(scoreLabel.snp.right).offset(4)
        }
    }
}
