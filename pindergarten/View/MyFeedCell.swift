//
//  MyFeedCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/21.
//

import UIKit

class MyFeedCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "MyFeedCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "1"))
        
        iv.contentMode = .scaleAspectFill
      
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        return iv
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
    
    //MARK: - Action
    
    //MARK: - Helpers
    private func setUpRoundShadow() {
        layer.applyShadow(color: UIColor(hex: 0xCBC6BB), alpha: 0.3, x: 0, y: 5, blur: 15)
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    private func configureUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
