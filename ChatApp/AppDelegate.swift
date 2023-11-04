//
//  AppDelegate.swift
//  ChatApp
//
//  Created by Tushar Patil on 08/09/23.
//

import UIKit
import IQKeyboardManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("Token ---- \(AuthManager.shared.getToken())")
        print("UserID---- \(AuthManager.shared.getUserID())")
        ChatSocketManager.shared.establishSocketConnection()
        IQKeyboardManager.shared().isEnabled = false
        UITextField.appearance().tintColor = .black
        let navigationBarAppearance = UINavigationBar.appearance()
           navigationBarAppearance.barTintColor = UIColor.white // Light mode background color
           navigationBarAppearance.tintColor = UIColor.white // Light mode text color
           
           if #available(iOS 13.0, *) {
               // Customize for dark mode (iOS 13 and later)
               let darkModeNavigationBarAppearance = UINavigationBarAppearance()
               darkModeNavigationBarAppearance.backgroundColor = UIColor.systemGray6 // Dark mode background color
               darkModeNavigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black] // Dark mode text color
               navigationBarAppearance.standardAppearance = darkModeNavigationBarAppearance
               navigationBarAppearance.scrollEdgeAppearance = darkModeNavigationBarAppearance
           }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

