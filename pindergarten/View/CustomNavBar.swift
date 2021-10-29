//
//  CustomNavBar.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/27.
//

import UIKit

class CustomNavBar: UIView {
    //MARK: - Properties
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.setDimensions(height: 30, width: 30)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    //MARK: - init
    init(title: String = "") {
        super.init(frame: .zero)
        
        titleLabel.text = title
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configureUI() {
        addSubview(backButton)
        addSubview(titleLabel)
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(snp.left).offset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(snp.top)
        }
    }
}
