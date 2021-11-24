//
//  SceneDelegate.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import UIKit
import SnapKit
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    lazy var autoLoginDataManager: AutoLoginDataManager = AutoLoginDataManager()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

        AF.request("\(Constant.BASE_URL)/api/users/auto-signin", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        self.window?.rootViewController = HomeTabBarController()
                    }
                    // 실패했을 때
                    else {
                        self.window?.rootViewController = UINavigationController(rootViewController: NewSplashController())
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.window?.rootViewController = UINavigationController(rootViewController: NewSplashController())
                }
            }
        
//        window?.rootViewController = UINavigationController(rootViewController: NewSplashController())
//        window?.rootViewController = UserProfileController()
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

