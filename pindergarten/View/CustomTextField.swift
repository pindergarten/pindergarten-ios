//
//  CustomTextField.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/26.
//

import UIKit

class CustomTextField: UITextField {
    
    var timeLabel = UILabel()
    
    init(placeholder: String, isSecure: Bool = false, time: Bool = false) {
        super.init(frame: .zero)
    
        if time == true {
            timeLabel.setWidth(40)
            timeLabel.text = "02:55"
            timeLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
            timeLabel.textColor = .subTextColor
            rightView = timeLabel
            rightViewMode = .always
        }
        
    
        font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        borderStyle = .none
        textColor = .subTextColor
        keyboardAppearance = .light
        setHeight(20)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor:UIColor.mainPlaceholerColor, .font:UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!])
        isSecureTextEntry = isSecure
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
