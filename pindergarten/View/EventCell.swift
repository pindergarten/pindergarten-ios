//
//  EventCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/02.
//

import UIKit

class EventCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "EventCell"
    
    var id: Int = 0
    
    let eventImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "2")
        return imageView
    }()
    
    private let dDayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.95
        view.layer.applyShadow(color: .black, alpha: 0.4, x: 1, y: 3, blur: 7)
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 25
        return view
    }()
    
    let dDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = UIColor(hex: 0x3D3D3D)
        label.text = "D-23"
        return label
    }()
    
    let eventLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.text = "이벤트 제목"
        label.textColor = UIColor(hex: 0x585858)
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    
    //MARK: - Helpers
    private func configureUI() {
        backgroundColor = .white
        
        addSubview(eventImage)
        addSubview(eventLabel)
        addSubview(dDayView)
        dDayView.addSubview(dDayLabel)
        
        eventImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-44)
        }
        
        eventLabel.snp.makeConstraints { make in
            make.top.equalTo(eventImage.snp.bottom).offset(10)
            make.left.right.equalTo(self.contentView)
        }
        
        dDayView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.right.bottom.equalTo(eventImage).offset(-10)
        }
        
        dDayLabel.snp.makeConstraints { make in
            make.center.equalTo(dDayView)
        }
    }
}
