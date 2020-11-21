//
//  WakaTime_TrackerApp.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI

@main
struct WakaTime_TrackerApp: App {
    
    init() {
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = #colorLiteral(red: 0.1603881121, green: 0.1677560508, blue: 0.2133775949, alpha: 1)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barStyle = .black
    }
    

    
    var body: some Scene {
        WindowGroup {
            RootView {
                ContentView()
                    .preferredColorScheme(.dark)
                    .environmentObject(neumorphism)
            }
        }
    }
}
