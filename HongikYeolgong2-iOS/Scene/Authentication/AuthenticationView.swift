

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var authCoordinator: AuthCoordinator
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            switch viewModel.authenticationState {
            case .unauthenticated:
                NavigationStack(path: $authCoordinator.paths) {
                    LoginView()
                        .foregroundStyle(.white)
                        .navigationDestination(for: AuthCoordinator.Scene.self) { scene in
                            authCoordinator.buildScreen(scene: scene)
                        }
                }
            case .authenticated:
                NavigationStack(path: $appCoordinator.paths) {
                    HomeView()
                        .foregroundStyle(.white)
                        .navigationDestination(for: AppCoordinator.Scene.self) { scene in
                            appCoordinator.buildScreen(scene: scene)
                        }
                }
            }
        }
        .onAppear {
            // 화면이 나타나면 로그인상태를 체크
                        viewModel.send(action: .checkAuthenticationState)
        }
    }
}
