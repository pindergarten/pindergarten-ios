//
//  HomeCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/01.
//

import UIKit
import Kingfisher

protocol HomeCellDelegate: AnyObject {
    func didTapHeartButton(tag: Int, index: Int)
}



class HomeCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "HomeCell"
    weak var delegate: HomeCellDelegate?
    var feedIndex = 0
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "heartButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        label.textColor = UIColor(hex: 0x3F3F3F)
        label.text = "Kevinni_v"
        return label
    }()
    
    let scriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        label.textColor = .mainTextColor
        label.text = "개팔자가 상팔자네요...."
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpRoundShadow()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    //MARK: - Action
    @objc func didTapHeartButton() {
        delegate?.didTapHeartButton(tag: heartButton.tag, index: feedIndex)
        print("DEBUG: TAPPED HEART BUTTON")
        if heartButton.currentImage == UIImage(named: "heartButton") {
            heartButton.setImage(#imageLiteral(resourceName: "filledHeartButton"), for: .normal)
        } else {
            heartButton.setImage(#imageLiteral(resourceName: "heartButton"), for: .normal)
        }
    }
    //MARK: - Helpers
    private func setUpRoundShadow() {
        layer.applyShadow(color: UIColor(hex: 0xCBC6BB), alpha: 0.6, x: 0, y: 5, blur: 15)
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        contentView.addSubview(imageView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(scriptionLabel)
        contentView.addSubview(heartButton)
        
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-44)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.equalTo(imageView.snp.left).offset(10)
            make.width.height.equalTo(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.equalTo(profileImageView.snp.right).offset(5)
            make.right.equalTo(contentView).offset(-10)
        }
        
        scriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(1)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalTo(nameLabel.snp.right)
        }
        
        heartButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.bottom.right.equalTo(imageView).offset(-5)
        }
        
        contentView.bringSubviewToFront(heartButton)
    }
}
