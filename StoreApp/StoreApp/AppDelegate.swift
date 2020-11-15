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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let testcontroller = UIViewController()
        testcontroller.view.backgroundColor = .blue
        window!.rootViewController = testcontroller
        window!.makeKeyAndVisible()
        return true
    }


}

