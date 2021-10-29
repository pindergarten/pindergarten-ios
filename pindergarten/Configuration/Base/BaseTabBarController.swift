//
//  MainTabBarController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configViewControllers()
    }

    func configViewControllers() {
        let homeVC = BaseViewController()
        let pindergartenVC = BaseViewController()
        let meAndPetVC = BaseViewController()

        
        let homeNC = UINavigationController(rootViewController: homeVC)
        let pindergartenNC = UINavigationController(rootViewController: pindergartenVC)
        let meAndPetNC = UINavigationController(rootViewController: meAndPetVC)
        
        self.viewControllers = [homeNC, pindergartenNC, meAndPetNC]
        
        
    }
    

}
