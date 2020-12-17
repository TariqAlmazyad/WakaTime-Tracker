//
//  WakaTime_TrackerApp.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI


import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Setting up firebase")
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
        return true
    }
}

@main
struct WakaTime_TrackerApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView {
                HomeVGridView()
                    .preferredColorScheme(.dark)
                    .environmentObject(neumorphism)
            }
        }
    }
}
