//
//  UIView.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/26.
//

import UIKit

extension UIView {
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .white) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }
}

extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur
//        shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
 
    }
}


extension UITabBar {
    // 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

extension UILabel {
    func countCurrentLines() -> Int {
         guard let text = self.text as NSString? else { return 0 }
         guard let font = self.font              else { return 0 }
         
         var attributes = [NSAttributedString.Key: Any]()
         
         // kern을 설정하면 자간 간격이 조정되기 때문에, 크기에 영향을 미칠 수 있습니다.
         if let kernAttribute = self.attributedText?.attributes(at: 0, effectiveRange: nil).first(where: { key, _ in
             return key == .kern
         }) {
             attributes[.kern] = kernAttribute.value
         }
         attributes[.font] = font
         
         // width을 제한한 상태에서 해당 Text의 Height를 구하기 위해 boundingRect 사용
         let labelTextSize = text.boundingRect(
             with: CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude),
             options: .usesLineFragmentOrigin,
             attributes: attributes,
             context: nil
         )
         
         // 총 Height에서 한 줄의 Line Height를 나누면 현재 총 Line 수
         return Int(ceil(labelTextSize.height / font.lineHeight))
     } 
}

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        print("화면 배율: \(UIScreen.main.scale)")
        // 배수
        print("origin: \(self), resize: \(renderImage)")
//        printDataSize(renderImage)
        return renderImage
        
    }
    
}


