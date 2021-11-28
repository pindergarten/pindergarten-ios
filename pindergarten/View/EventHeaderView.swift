//
//  EventHeaderView.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/10.
//

import UIKit

protocol EventHeaderDelegate: AnyObject {
    func goToCommentVC()
    func didTapHeartButton()
}



class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
 
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}


class EventHeaderView: UIView  {
    //MARK: - Properties
    weak var delegate: EventHeaderDelegate?
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.numberOfLines = 0
        label.textColor = .mainTextColor
//        label.text = "이벤트 제목"
       
        return label
    }()
    
    let eventImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "eventimage")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()

    lazy var eventStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [eventNameLabel, eventImage])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
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

    lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()

    let heartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x858585)
        label.text = "294"
        return label
    }()

    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "commentImage"), for: .normal)
        button.addTarget(self, action: #selector(goToCommentVC), for: .touchUpInside)
        return button
    }()

    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x858585)
        label.text = "294"
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
    
    @objc private func goToCommentVC() {
        print("DEBUG: TAPPED HEADER COMMENT BUTTON")
        delegate?.goToCommentVC()
    }
    
    @objc private func didTapHeartButton() {
        print("DEBUG: TAPPED HEADER HEART BUTTON")
        delegate?.didTapHeartButton()
    }
    
    //MARK: - Helpers
    private func configureUI() {

//        addSubview(eventNameLabel)
//        addSubview(eventImage)
        addSubview(eventStack)
        addSubview(dDayView)
        dDayView.addSubview(dDayLabel)
        addSubview(heartButton)
        addSubview(heartLabel)
        addSubview(commentButton)
        addSubview(commentLabel)
        
        
//        eventNameLabel.snp.makeConstraints { make in
//            make.top.equalTo(self).offset(20)
//            make.left.right.equalTo(self).inset(20)
//        }
//
//        eventImage.snp.makeConstraints { make in
//            make.top.equalTo(eventNameLabel.snp.bottom).offset(8)
//            make.width.equalTo(Device.width - 40)
//            make.bottom.equalTo(heartButton.snp.top).offset(-15)
//            make.centerX.equalTo(self)
//        }
        
        eventStack.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.left.right.equalTo(self).inset(20)
            make.bottom.equalTo(heartButton.snp.top).offset(-15)
        }
        
        dDayView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.equalTo(eventImage).offset(10)
            make.right.equalTo(eventImage).offset(-10)
        }
        
        dDayLabel.snp.makeConstraints { make in
            make.center.equalTo(dDayView)
        }
        
        heartButton.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20)
            make.width.height.equalTo(25)
            make.bottom.equalTo(self)
        }
        
        heartLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.left.equalTo(heartButton.snp.right).offset(6)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.left.equalTo(heartLabel.snp.right).offset(12)
            make.width.height.equalTo(25)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton)
            make.left.equalTo(commentButton.snp.right).offset(6)

        }

    }
}


