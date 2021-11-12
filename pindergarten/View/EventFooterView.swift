//
//  EventFooterView.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/12.
//

import UIKit

protocol EventFooterDelegate: AnyObject {
    func didTapMoreCommentButton()
}




class EventFooterView: UIView  {
    //MARK: - Properties
    weak var delegate: EventFooterDelegate?
    
    let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글 더보기"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        label.textColor = UIColor(hex: 0xA1A1A1)
        return label
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        let tapMoreLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMoreCommentButton(sender:)))
        
        moreLabel.isUserInteractionEnabled = true
      
        moreLabel.addGestureRecognizer(tapMoreLabelGestureRecognizer)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Action
    
    @objc private func didTapMoreCommentButton(sender: UITapGestureRecognizer) {
        print("DEBUG: TAPPED FOOTER COMMENT BUTTON")
        delegate?.didTapMoreCommentButton()
    }
    

    
    //MARK: - Helpers
    private func configureUI() {

        addSubview(moreLabel)
  

        moreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-20)
        }
    }
}



