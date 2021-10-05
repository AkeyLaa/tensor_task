//
//  AppDelegate.swift
//  tensor_task
//
//  Created by Sergey on 29.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: UIApplicationDelegate? {
        return UIApplication.shared.delegate
    }

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = ContactListModuleController()
        window?.rootViewController = UINavigationController(rootViewController: root)
        window?.makeKeyAndVisible()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "ContactBackground")
        appearance.titleTextAttributes = [
          NSAttributedString.Key.foregroundColor: UIColor.systemGray2
        ]
        appearance.largeTitleTextAttributes = [
          NSAttributedString.Key.foregroundColor: UIColor.systemGray2
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
        return true
    }
}
