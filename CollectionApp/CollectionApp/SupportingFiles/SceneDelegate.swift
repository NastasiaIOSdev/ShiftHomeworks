//
//  SceneDelegate.swift
//  CollectionApp
//
//  Created by Анастасия Ларина on 13.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let mainVC = CollectionAssemly.build()
             let navigationVC = UINavigationController(rootViewController: mainVC)
             guard let windowScene = (scene as? UIWindowScene) else { return }
             self.window = UIWindow(windowScene: windowScene)
             self.window?.rootViewController = navigationVC
             self.window?.makeKeyAndVisible()
    }
}

