//
//  AppDelegate.swift
//  PexelsAPI
//
//  Created by Vitaliy on 25.01.2021.
//

import UIKit
import Swinject

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    var resolver: Resolver!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DependencyContainer.shared.configure()
        resolver = DependencyContainer.shared.resolver
        
        let window = UIWindow()
        window.rootViewController = TabBarCreator(resolver: resolver).createModule()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
