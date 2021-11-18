//
//  DetailPindergartenHeaderCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import UIKit
import ImageSlideshow
import Cosmos



protocol DetailPindergartenHeaderCellDelegate: AnyObject {
    func didTapBackButton()
    func didTapCallButton()
    func didTapHeartButton()
    func didTapImage(imageSlide: ImageSlideshow)
}

class DetailPindergartenHeaderCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "DetailPindergartenHeaderController"

    weak var delegate: DetailPindergartenHeaderCellDelegate?
    
    let imageInput = [ImageSource(image: #imageLiteral(resourceName: "backgroundImage"))]
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    let labelBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x2B2B2B, alpha: 0.56)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let labelPageIndicator: LabelPageIndicator = {
        let indicator = LabelPageIndicator()
        indicator.textColor = .white
        indicator.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        return indicator
    }()
    
    let imageContainerView: UIView = {
        let view = UIView()
        view.layer.applyShadow(color: .black, alpha: 0.25, x: 0, y: 4, blur: 9)
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
        
        return view
    }()
    
    lazy var imageSlide: ImageSlideshow = {
        let image = ImageSlideshow()
        image.contentScaleMode = .scaleAspectFill
        image.circular = false
        image.pageIndicator = labelPageIndicator
        image.pageIndicatorPosition = PageIndicatorPosition(horizontal: .right(padding: 30), vertical: .customTop(padding: 20))
        image.activityIndicator = DefaultActivityIndicator(style: .large, color: .mainYellow)

        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        image.setImageInputs(imageInput)
        return image
    }()
    
    lazy var callButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "callButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapCallButton), for: .touchUpInside)
        return button
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "detailHeart"), for: .normal)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        label.textColor = .mainTextColor
        label.text = "하울팟 케어클럽 서초본점"
        label.numberOfLines = 1
        return label
    }()
    
    let pindergartenAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = UIColor(hex: 0x4E5261)
        label.text = "서울특별시 서초구 서초대로58길 36 4~5F"
        label.numberOfLines = 1
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.textColor = UIColor(hex: 0x4E5261)
        label.text = "0/5"
        return label
    }()
    
    let starView: CosmosView = {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.fillMode = .precise
        view.settings.starSize = 14
        view.settings.starMargin = 3
        view.settings.filledImage = UIImage(named: "filledStar")
        view.settings.emptyImage = UIImage(named: "star")
        view.rating = 0
        return view
    }()
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE9E9E9)
        return view
    }()

    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
//        imageSlide.addGestureRecognizer(gestureRecognizer)
        if imageInput.count == 1 || imageInput.count == 0 {
            labelBackView.isHidden = true
        }
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    @objc private func didTapImage() {
        delegate?.didTapImage(imageSlide: imageSlide)

    }

    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()

    }
    
    @objc private func didTapCallButton() {
        delegate?.didTapCallButton()
    }
    
    @objc private func didTapHeartButton() {
        delegate?.didTapHeartButton()
    }
    //MARK: - Helpers

    private func configureUI() {

        contentView.addSubview(imageContainerView)
        imageSlide.addSubview(labelBackView)
        imageContainerView.addSubview(imageSlide)
        contentView.addSubview(backButton)
        contentView.addSubview(callButton)
        contentView.addSubview(heartButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(pindergartenAddressLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(starView)
        contentView.addSubview(separateLine)

        
        imageContainerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(337)
        }
        
        imageSlide.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(imageContainerView)
            
        }
        
        labelBackView.snp.makeConstraints { make in
            make.center.equalTo(labelPageIndicator).offset(-1)
            make.width.equalTo(47)
            make.height.equalTo(20)
        }
        
        imageSlide.bringSubviewToFront(labelPageIndicator)
        
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).offset(22)
            make.left.equalTo(contentView.self).offset(8)
            make.width.height.equalTo(30)
        }
        
        callButton.snp.makeConstraints { make in
            make.centerY.equalTo(imageSlide.snp.bottom)
            make.width.height.equalTo(50)
            make.right.equalTo(heartButton.snp.left).offset(-20)
        }
        
        heartButton.snp.makeConstraints { make in
            make.centerY.equalTo(imageSlide.snp.bottom)
            make.width.height.equalTo(50)
            make.right.equalTo(contentView).offset(-27)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageSlide.snp.bottom).offset(38)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        pindergartenAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalTo(nameLabel)
            make.right.equalTo(contentView).offset(-20)
        }

        
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(pindergartenAddressLabel.snp.bottom).offset(2)
        }
        
        starView.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel)
            make.left.equalTo(scoreLabel.snp.right).offset(4)
        }

        separateLine.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(22)
            make.left.right.equalTo(contentView)
            make.height.equalTo(6)
            make.bottom.equalTo(contentView)
        }
    }
}

