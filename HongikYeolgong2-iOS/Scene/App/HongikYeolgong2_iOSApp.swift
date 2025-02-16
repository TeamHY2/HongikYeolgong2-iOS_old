

import SwiftUI
import Firebase

@main
struct HongikYeolgong2_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var timerViewModel = TimerViewModel()
    @StateObject private var calendarViewModel = CalendarViewModel()
    @StateObject private var remoteConfigManager = RemoteConfigManager()
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            InitialView()
                .environmentObject(authViewModel)
                .environmentObject(timerViewModel)
                .environmentObject(calendarViewModel)
                .environmentObject(remoteConfigManager)
                .environmentObject(homeViewModel)
                .task {
                    await LocalNotificationService.shared.checkPermission()
                }            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
#if DEBUG
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-dev", ofType: "plist")!
#else
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
#endif
        let options: FirebaseOptions? = FirebaseOptions.init(contentsOfFile: filePath)
        
        FirebaseApp.configure(options: options!)
                
        setupDependency()
        return true
    }
    
    func setupDependency() {
        DIContainer.shared.register(type: AuthenticationServiceType.self, service: AuthenticationService())
        DIContainer.shared.register(type: StudyRoomRepositoryType.self, service: StudyRoomRepository())
        DIContainer.shared.register(type: UserRepositoryType.self, service: UserRepository())
    }
}


