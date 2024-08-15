

import SwiftUI

struct InitialView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var authCoordinator: AuthCoordinator
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .none:
                SplashView()
            case .unauthenticated:
                NavigationStack(path: $authCoordinator.paths) {
                    LoginView()
                        .navigationDestination(for: AuthCoordinator.Scene.self) { scene in
                            authCoordinator.buildScreen(scene: scene)
                        }
                }
            case .authenticated:
                NavigationStack(path: $appCoordinator.paths) {
                    HomeView()
                        .navigationDestination(for: AppCoordinator.Scene.self) { scene in
                            appCoordinator.buildScreen(scene: scene)
                        }
                }
            }
        }
        .alert(title: authViewModel.errorMessage, isPresented: $authViewModel.showingErrorAlert, confirmAction: {})
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }.onReceive(authViewModel.$user, perform: { user in
            if let uid = user?.id {
                calendarViewModel.send(action: .getCalendar(uid))
            }            
        })
    }
}
