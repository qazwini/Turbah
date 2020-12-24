//
//  AppDelegate.swift
//  Turbah
//
//  Created by MMQ on 7/15/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupScreen()
        setupDefaults()
        return true
    }
    
    
    // MARK: - Custom Funcs
    
    func setupScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        window?.rootViewController = ViewController()
    }
    
    func setupDefaults() {
        save.register(defaults: [
            "TurbahDistance" : 3,
            "NorthType" : true
        ])
    }

}
