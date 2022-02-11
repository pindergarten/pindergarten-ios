//
//  HomeCollectionResueableView.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2022/02/12.
//

import UIKit

class HomeFooterCollectionResueableView: UICollectionReusableView {
    static let identifier = "HomeFooterCollectionResueableView"
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        spinner.tintColor = .mainYellow
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
