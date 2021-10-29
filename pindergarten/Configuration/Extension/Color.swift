//
//  Color.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import UIKit

extension UIColor {
    //MARK: - hex code를 사용하여 정의
    
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    class var mainYellow: UIColor { UIColor(hex: 0xFBD774)}
    class var mainLightYellow: UIColor { UIColor(hex: 0xFFE9A0)}
    class var mainBrown: UIColor { UIColor(hex: 0x9F5D1F)}
    class var mainPink: UIColor { UIColor(hex: 0xF4847D)}
    class var mainTextColor: UIColor { UIColor(hex: 0x424242)}
    class var mainPlaceholerColor: UIColor { UIColor(hex: 0xBFBFBF)}
    class var mainlineColor: UIColor { UIColor(hex: 0xE9E9E9)}
    class var subLightTextColor: UIColor { UIColor(hex: 0x5A5A5A, alpha: 0.7)}
    class var subTextColor: UIColor { UIColor(hex: 0x5A5A5A, alpha: 1)}
}
