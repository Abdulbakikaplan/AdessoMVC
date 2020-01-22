//
//  AppDelegate.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startApplication()
        
        return true
    }

    func startApplication() {
        let splashVC = SplashVC(nibName: "SplashVC", bundle: nil)
         window = UIWindow(frame: UIScreen.main.bounds)
         window?.rootViewController = splashVC
         window?.makeKeyAndVisible()
    }

}

