//
//  DetailEventController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/02.
//

import UIKit

class DetailEventController: BaseViewController {
    //MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private let seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.numberOfLines = 0
        label.textColor = .mainTextColor
        label.text = "이벤트 제목"
        return label
    }()
    
    private let eventImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "2")
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
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
    
    private let dDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = UIColor(hex: 0x3D3D3D)
        label.text = "D-23"
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "feedFilledHeartImage"), for: .selected)
        return button
    }()
    
    private let heartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x858585)
        label.text = "294"
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "commentImage"), for: .normal)
        button.addTarget(self, action: #selector(goToCommentVC), for: .touchUpInside)
        return button
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x858585)
        label.text = "294"
        return label
    }()
    
    private let commentSeperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xEAEAEA)
        return view
    }()
    
    private lazy var commentTextButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.backgroundColor = .mainLightYellow
        button.addTarget(self, action: #selector(goToCommentVC), for: .touchUpInside)
        return button
    }()
    
    private let commentPlaceHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글을 입력하세요 :)"
        label.textColor = UIColor(hex: 0x7E7E7E, alpha: 0.8)
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        return label
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func goToCommentVC() {
        navigationController?.pushViewController(EventCommentController(), animated: true)
    }
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(seperateLine)
        view.addSubview(eventNameLabel)
        view.addSubview(eventImage)
        view.addSubview(dDayView)
        dDayView.addSubview(dDayLabel)
        view.addSubview(heartButton)
        view.addSubview(heartLabel)
        view.addSubview(commentButton)
        view.addSubview(commentLabel)
        view.addSubview(commentSeperateLine)
        view.addSubview(commentTextButton)
        commentTextButton.addSubview(commentPlaceHolderLabel)

        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        eventNameLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
        }
        
        eventImage.snp.makeConstraints { make in
            make.top.equalTo(eventNameLabel.snp.bottom).offset(8)
            make.width.height.equalTo(Device.width - 40)
            make.centerX.equalTo(view)
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
            make.top.equalTo(eventImage.snp.bottom).offset(15)
            make.left.equalTo(view).offset(20)
            make.width.height.equalTo(25)
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
        
        commentSeperateLine.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.left.right.equalTo(view)
            make.bottom.equalTo(commentTextButton.snp.top).offset(-10)
        }
        
        commentTextButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-10)
            make.height.equalTo(40)
        }
        
        commentPlaceHolderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(commentTextButton)
            make.left.equalTo(commentTextButton).offset(16)
        }
    }
}
