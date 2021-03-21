//
//  AppDelegate.swift
//  StoreApp
//
//  Created by Scizor on 14/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: SearchProductCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navController
        coordinator = SearchProductCoordinator(navigationController: navController)
        coordinator?.start()
        window!.makeKeyAndVisible()
        return true
    }
}

