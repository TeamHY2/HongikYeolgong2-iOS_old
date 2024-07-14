//
//  HongikYeolgong2_iOSApp.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/1/24.
//

import SwiftUI
import Firebase

@main
struct HongikYeolgong2_iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var coordinator = SceneCoordinator()
    @StateObject var container: DIContainer = .init(services: Services())
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environmentObject(coordinator)
//                .environmentObject(container)
            AuthenticationView(authViewModel: .init(contanier: container))
                .environmentObject(container)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
    
}
