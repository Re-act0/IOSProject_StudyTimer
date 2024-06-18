//
//  SceneDelegate.swift
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: SettingViewController())
        window?.makeKeyAndVisible()
        
        checkDate()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("sceneDidDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("sceneDidBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("sceneWillResignActive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("sceneWillEnterForeground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("sceneDidEnterBackground")
    }
    
    private func checkDate() {
        guard let today = UserDefaults.standard.string(forKey: ConstantsKey.todayDate) else {
            return
        }
        if Date().toString() != today {
            let studyTime = UserDefaults.standard.integer(forKey: ConstantsKey.todayStudyTime)
            let sleepTime = UserDefaults.standard.integer(forKey: ConstantsKey.todaySleepTime)
            
            UserDefaults.standard.set(studyTime, forKey: ConstantsKey.yesterdayStudyTime)
            UserDefaults.standard.set(sleepTime, forKey: ConstantsKey.yesterdaySleepTime)
            
            UserDefaults.standard.set(0, forKey: ConstantsKey.todayStudyTime)
            UserDefaults.standard.set(0, forKey: ConstantsKey.todaySleepTime)
        }
    }
}

