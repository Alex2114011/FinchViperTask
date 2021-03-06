//
//  SceneDelegate.swift
//  FinchViperTask
//
//  Created by Alex on 03.11.2021.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let rootViewController = ListScreenAssembly.assembleModule()
        let navigationController = UINavigationController(rootViewController: rootViewController)

        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
