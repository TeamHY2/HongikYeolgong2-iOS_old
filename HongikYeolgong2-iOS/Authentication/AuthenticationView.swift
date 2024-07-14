//
//  AuthenticationView.swift
//  HongikYeolgong2-iOS
//
//  Created by 변정훈 on 7/11/24.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var authViewModel: AuthenticationViewModel
    var body: some View {
        switch authViewModel.authenticationState {
        case .unauthenticated:
            LoginView()
                .environmentObject(authViewModel)
        case .authenticated:
            HomeView(viewModel: HomeViewModel())
        }
    }
}
