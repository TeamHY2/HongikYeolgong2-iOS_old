

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var coordinator = SceneCoordinator()
    @StateObject var authViewModel: AuthenticationViewModel
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginView()
                    .environmentObject(authViewModel)
            case .authenticated:
                HomeView(viewModel: HomeViewModel())
                    .environmentObject(coordinator)
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState) 
        }
    }
}
