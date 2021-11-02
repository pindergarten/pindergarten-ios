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
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
//        // 네비게이션바 밑줄, 배경색 없애기
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
}
