//
//  SceneDelegate.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import UIKit
import SwiftUI
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let injectionContainer = AppDependencyContainer()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let vc = injectionContainer.makeMainViewController()
        window?.makeKeyAndVisible()
        window?.rootViewController = vc
    }
}

