//
//  AppDelegate.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import UIKit
import DropDown
import NMapsMap
//import Siren

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 11)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 11)!], for: .selected)
        
//        window?.makeKeyAndVisible()
//        let siren = Siren.shared
//        siren.apiManager = APIManager(country: .korea) //기준 위치 대한민국 앱스토어로 변경
//        siren.presentationManager = PresentationManager(forceLanguageLocalization: .korean) //알림 메시지 한국어로
//        siren.rulesManager = RulesManager(majorUpdateRules: .critical,
//                                          minorUpdateRules: .annoying,
//                                          patchUpdateRules: .default,
//                                          revisionUpdateRules: .relaxed)
//        siren.wail()
           
        NMFAuthManager.shared().clientId = NMaps.clientID
        DropDown.startListeningToKeyboard()
        sleep(2)
    
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

