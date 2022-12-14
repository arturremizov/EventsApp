//
//  SceneDelegate.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        self.appCoordinator = appCoordinator
    }
}

