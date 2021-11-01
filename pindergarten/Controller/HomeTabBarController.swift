//
//  HomeTabBarController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/31.
//

import UIKit

class HomeTabBarController: UITabBarController {

    //MARK: - Properties
    private let containerView = UIView()
    private let innerView = UIView()

   
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        configureViewControllers()
    
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        changeHeightOfTabBar()
    }
    //MARK: - Helpers
    func changeHeightOfTabBar() {
        
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame = tabBar.frame

            if !Device.isNotch {
                tabFrame.size.height = 80
                tabFrame.origin.y = view.frame.size.height - 80
            } else {
                tabFrame.size.height = 80 + Device.bottomInset
                tabFrame.origin.y = view.frame.size.height - (80 + Device.bottomInset)
            }
            
            tabBar.frame = tabFrame
        }
    }
    func setupTabBar() {
        tabBar.itemPositioning = .centered
        tabBar.itemWidth = 60
        tabBar.itemSpacing = 40
        
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: -5, blur: 12)
        tabBar.clipsToBounds = true
        tabBar.layer.masksToBounds = false
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.cornerRadius = 35
        }
    
    func configureViewControllers() {

        let pindergarten = templeteNavigationController(title: "핀더가든", unselectedImage: #imageLiteral(resourceName: "homeTabButton"),
                                                selectedImage: #imageLiteral(resourceName: "selectedHomeTabButton"),
                                                rootViewController: PindergartenViewController())
        let search = templeteNavigationController(title: "펫 유치원", unselectedImage: #imageLiteral(resourceName: "pindergartenTabButton"),
                                                  selectedImage: #imageLiteral(resourceName: "selectedPindergartenTabButton"),
                                                  rootViewController: SearchViewController())
        let meAndPet = templeteNavigationController(title: "나와 펫", unselectedImage: #imageLiteral(resourceName: "meAndPetTabButton"),
                                                         selectedImage: #imageLiteral(resourceName: "selectedMeAndPetTabButton"),
                                                         rootViewController: MeAndPetViewController())
        
        viewControllers = [pindergarten, search, meAndPet]
        
        tabBar.tintColor = .mainBrown
        tabBar.unselectedItemTintColor = UIColor(hex: 0x9D9D9D)
        
    }
    
    func templeteNavigationController(title: String, unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
//        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.title = title
        
//        tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
        nav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -18)
    
        return nav
    }

}


