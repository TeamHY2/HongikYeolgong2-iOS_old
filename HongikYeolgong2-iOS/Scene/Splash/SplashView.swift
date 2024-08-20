//
//  SplashView.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var coordinator: AuthCoordinator
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var body: some View {
        ZStack {
            Color(.customBackground)
                .ignoresSafeArea()
            Text("스플래쉬뷰")
                .foregroundStyle(.white)
                .font(.title)
        }
        .customNavigation(right: {
            Button(action: {
                coordinator.push(.loginOnboarding)
                print(authViewModel.authenticationState)
            }, label: {
                Image("ic_back")
            })
        })

    }
}

#Preview {
    SplashView()
}
