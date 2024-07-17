

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject private var coordinator: SceneCoordinator
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            switch viewModel.authenticationState {
            case .unauthenticated:
                LoginView()
            case .authenticated:
                Group {
                    NavigationStack(path: $coordinator.paths) {
                        HomeView()
                            .navigationDestination(for: SceneType.self) { scene in
                                coordinator.buildScreen(scene: scene)
                            }
                            .sheet(item: $coordinator.sheet) { sheet in
                                coordinator.buildScreen(sheet: sheet)
                            }
                            .fullScreenCover(item: $coordinator.fullScreen) { fullScreen in
                                coordinator.buildScreen(fullScreen: fullScreen)
                            }
                    }
                }
            }
        }
        .onAppear {
            viewModel.send(action: .checkAuthenticationState)
        }
    }
}
