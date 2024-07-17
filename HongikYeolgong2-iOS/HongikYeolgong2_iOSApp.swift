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
//    @StateObject var container: DIContainer = .init(services: Services())
//    @StateObject var container: DIContainer = {
//        let container = DIContainer()
//        container.register(AuthenticationServiceType.self, instance: AuthenticationService())
//        return container
//    }()
//    @StateObject var container: DIContainer
//    init() {
//            let container = DIContainer()
//            container.register(AuthenticationServiceType.self, instance: AuthenticationService())
//            _container = StateObject(wrappedValue: container)
//        }
//    init() {
//            let container = DIContainer.shared
//        container.register(AuthenticationServiceType.self, instance: AuthenticationService())
//        }
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environmentObject(coordinator)
//                .environmentObject(container)
//            AuthenticationView(authViewModel: .init(contanier: DIContainer.shared))
//                .environmentObject(DIContainer.shared)
            AuthenticationView(authViewModel: AuthenticationViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        registerDependency()
        
        return true
    }
    
}

func registerDependency() {
    DIContainer.shared.register(AuthenticationService() as AuthenticationServiceType)
}
