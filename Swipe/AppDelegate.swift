//
//  AppDelegate.swift
//  Swipe
//
//  Created by MuhammadAli on 03/12/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        
        window?.rootViewController = New()
        window?.makeKeyAndVisible()

        return true
    }

 
}

