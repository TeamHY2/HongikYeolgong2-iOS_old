

import SwiftUI
import Firebase

@main
struct HongikYeolgong2_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AuthenticationView()
                .environmentObject(SceneCoordinator())
                .environmentObject(AuthenticationViewModel())
                .environmentObject(TimerViewModel())
                .environmentObject(CalendarViewModel())
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
    DIContainer.shared.register(CalendarRepositoryMock() as CalendarRepositoryType)
}
