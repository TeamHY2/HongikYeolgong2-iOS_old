

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject private var coordinator: SceneCoordinator
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            switch viewModel.authenticationState {
            case .unauthenticated:
                NavigationStack(path: $coordinator.authPath) {
                    LoginView()                        
                }
            case .authenticated:
                LoginView()         
//                Group {
//                    NavigationStack(path: $coordinator.paths) {
//                        HomeView()
//                            .navigationDestination(for: SceneType.self) { scene in
//                                coordinator.buildScreen(scene: scene)
//                            }
//                            .sheet(item: $coordinator.sheet) { sheet in
//                                coordinator.buildScreen(sheet: sheet)
//                            }
//                            .fullScreenCover(item: $coordinator.fullScreen) { fullScreen in
//                                coordinator.buildScreen(fullScreen: fullScreen)
//                            }
//                    }
//                }
            }
        }
        .onAppear {
            // 화면이 나타나면 로그인상태를 체크
            viewModel.send(action: .checkAuthenticationState)
        }
    }
}
