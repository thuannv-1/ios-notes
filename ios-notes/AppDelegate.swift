//
//  AppDelegate.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit
import CoreData
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFirebase()
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }
}

extension AppDelegate {
    private func setupFirebase() {
        // Please setup Gooogle API_KEY & GOOGLE_APP_ID before open comment below
        // FirebaseApp.configure()
    }
}
