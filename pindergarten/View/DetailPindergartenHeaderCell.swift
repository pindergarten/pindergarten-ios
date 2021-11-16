//
//  DetailPindergartenHeaderCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import UIKit
import ImageSlideshow
import Cosmos

let imageInput = [ImageSource(image: #imageLiteral(resourceName: "backgroundImage")),ImageSource(image: #imageLiteral(resourceName: "4")),ImageSource(image: #imageLiteral(resourceName: "2")),ImageSource(image: #imageLiteral(resourceName: "4")),ImageSource(image: #imageLiteral(resourceName: "backgroundImage")),ImageSource(image: #imageLiteral(resourceName: "backgroundImage")),ImageSource(image: #imageLiteral(resourceName: "backgroundImage")),ImageSource(image: #imageLiteral(resourceName: "5")),ImageSource(image: #imageLiteral(resourceName: "backgroundImage"))]

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
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private let labelBackView: UIView = {
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
        return view
    }()
    
    lazy var imageSlide: ImageSlideshow = {
        let image = ImageSlideshow()
        image.contentScaleMode = .scaleAspectFill
        image.circular = false
        image.pageIndicator = labelPageIndicator
        image.pageIndicatorPosition = PageIndicatorPosition(horizontal: .right(padding: 0), vertical: .customTop(padding: 20))
        image.activityIndicator = DefaultActivityIndicator(style: .large, color: .mainYellow)

        image.layer.cornerRadius = 30
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
//        view.addSubview(scrollView)
//        scrollView.addSubview(containerView)
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
//        containerView.addSubview(workTimeLabel)
//        containerView.addSubview(workTimeInfoLabel)
//        containerView.addSubview(line)
//        containerView.addSubview(useLabel)
//        containerView.addSubview(useInfoLabel)
//        containerView.addSubview(line2)
//        containerView.addSubview(basicInfoLabel)
//        containerView.addSubview(callLabel)
//        containerView.addSubview(callInfoLabel)
//        containerView.addSubview(addressLabel)
//        containerView.addSubview(addressInfoLabel)
//        containerView.addSubview(homepageLabel)
//        containerView.addSubview(homepageInfoLabel)
//        containerView.addSubview(socialLabel)
//        containerView.addSubview(socialInfoLabel)
//        containerView.addSubview(separateLine2)
//        view.addSubview(blogReviewTableView)
        
//        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(view)
//            make.centerX.equalTo(view)
//            make.width.equalTo(view)
//            make.bottom.equalTo(view.snp.bottomMargin)
//        }
//
//        containerView.snp.makeConstraints { make in
//            make.top.left.right.bottom.equalTo(scrollView)
//            make.width.equalTo(scrollView)
//            make.height.greaterThanOrEqualTo(scrollView)
//        }
        
        imageContainerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(337)
        }
        
        imageSlide.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(imageContainerView)
            
        }
        
        labelBackView.snp.makeConstraints { make in
            make.center.equalTo(labelPageIndicator)
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
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(nameLabel)
            make.right.equalTo(contentView).offset(-20)
        }

        
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(pindergartenAddressLabel.snp.bottom).offset(4)
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
//
//        workTimeLabel.snp.makeConstraints { make in
//            make.top.equalTo(separateLine.snp.bottom).offset(28)
//            make.left.equalTo(containerView).offset(20)
//            make.right.equalTo(containerView).offset(-20)
//        }
//
//        workTimeInfoLabel.snp.makeConstraints { make in
//            make.top.equalTo(workTimeLabel.snp.bottom).offset(18)
//            make.left.equalTo(containerView).offset(20)
//            make.right.equalTo(containerView).offset(-20)
//        }
//
//        line.snp.makeConstraints { make in
//            make.top.equalTo(workTimeInfoLabel.snp.bottom).offset(18)
//            make.left.equalTo(containerView).offset(20)
//            make.right.equalTo(containerView).offset(-20)
//            make.height.equalTo(1)
//        }
//
//        useLabel.snp.makeConstraints { make in
//            make.top.equalTo(line.snp.bottom).offset(20)
//            make.left.equalTo(containerView).offset(20)
//            make.right.equalTo(containerView).offset(-20)
//        }
//
//        useInfoLabel.snp.makeConstraints { make in
//            make.top.equalTo(useLabel.snp.bottom).offset(18)
//            make.left.equalTo(containerView).offset(20)
//            make.right.equalTo(containerView).offset(-20)
//        }
//
//        line2.snp.makeConstraints { make in
//            make.top.equalTo(useInfoLabel.snp.bottom).offset(18)
//            make.left.equalTo(containerView).offset(20)
//            make.right.equalTo(containerView).offset(-20)
//            make.height.equalTo(1)
//        }
//
//        basicInfoLabel.snp.makeConstraints { make in
//            make.top.equalTo(line2.snp.bottom).offset(20)
//            make.left.equalTo(containerView).offset(20)
//            make.right.equalTo(containerView).offset(-20)
//        }
//
//        callLabel.snp.makeConstraints { make in
//            make.top.equalTo(basicInfoLabel.snp.bottom).offset(18)
//            make.left.equalTo(containerView).offset(20)
//            make.width.equalTo(52)
//        }
//
//        callInfoLabel.snp.makeConstraints { make in
//            make.top.equalTo(callLabel)
//            make.left.equalTo(callLabel.snp.right).offset(26)
//
//            make.right.equalTo(containerView).offset(-20)
//        }
//
//        addressLabel.snp.makeConstraints { make in
//            make.top.equalTo(callInfoLabel.snp.bottom).offset(18)
//            make.left.equalTo(callLabel)
//            make.width.equalTo(52)
//        }
//
//        addressInfoLabel.snp.makeConstraints { make in
//            make.top.equalTo(addressLabel)
//            make.left.equalTo(callInfoLabel.snp.left)
//            make.right.equalTo(containerView).offset(-20)
//        }
//
//        homepageLabel.snp.makeConstraints { make in
//            make.top.equalTo(addressInfoLabel.snp.bottom).offset(18)
//            make.left.equalTo(callLabel)
//            make.width.equalTo(52)
//        }
//
//        homepageInfoLabel.snp.makeConstraints { make in
//            make.top.equalTo(homepageLabel)
//            make.left.equalTo(callInfoLabel.snp.left)
//            make.right.equalTo(containerView).offset(-20)
//        }
//
//        socialLabel.snp.makeConstraints { make in
//            make.top.equalTo(homepageInfoLabel.snp.bottom).offset(18)
//            make.left.equalTo(callLabel)
//            make.width.equalTo(52)
//        }
//
//        socialInfoLabel.snp.makeConstraints { make in
//            make.top.equalTo(socialLabel)
//            make.left.equalTo(callInfoLabel.snp.left)
//            make.right.equalTo(containerView).offset(-20)
//
//        }
//
//        separateLine2.snp.makeConstraints { make in
//            make.top.equalTo(socialInfoLabel.snp.bottom).offset(33)
//            make.left.right.equalTo(containerView)
//            make.height.equalTo(6)
//
//        }
//
//        blogReviewTableView.snp.makeConstraints { make in
//            make.top.equalTo(separateLine2.snp.bottom)
//            make.left.equalTo(containerView).offset(20)
//            make.right.equalTo(containerView).offset(-20)
//            make.bottom.equalTo(containerView)
//        }
    }
}

