//
//  BaseViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import UIKit

class BaseViewController: UIViewController {
    //MARK: - Properties
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeRecognizer()
        dismissKeyboardWhenTappedAround()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
//        // 네비게이션바 밑줄, 배경색 없애기
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
   func swipeRecognizer() {
       let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
       swipeRight.direction = UISwipeGestureRecognizer.Direction.right
       self.view.addGestureRecognizer(swipeRight)
       
   }
   
   @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
       if let swipeGesture = gesture as? UISwipeGestureRecognizer {
           switch swipeGesture.direction{
           case UISwipeGestureRecognizer.Direction.right:
               // 스와이프 시, 원하는 기능 구현.
            self.navigationController?.popViewController(animated: true)
           default: break
           }
       }
   }


}
