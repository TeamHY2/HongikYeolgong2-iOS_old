

import SwiftUI

struct InitialView: View {    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    
    @State private var isFirstLaunch = true
    
    var appInitCompleted: AuthenticationState {
        if authViewModel.authenticationState == .authenticated && !calendarViewModel.isLoading {
            return .authenticated
        } else if (authViewModel.authenticationState == .unauthenticated && !isFirstLaunch) || (authViewModel.authenticationState == .unauthenticated && isFirstLaunch) {
            return .unauthenticated
        } else {
            return .pending
        }
    }
    
    // 앱이 모든데이터를 받아왔을때 메인화면을 보여줌
    var body: some View {
        VStack {
            switch appInitCompleted {
                // 유저정보를 확인중인 상태
            case .pending:
                    SplashView()
            case .unauthenticated:
                NavigationView {
                    LoginView()
                }
            case .authenticated:
                NavigationView {
                    HomeView()
                }
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }.onReceive(authViewModel.$user, perform: { user in
            if let uid = user?.id {
                calendarViewModel.send(action: .getCalendar(uid))
                isFirstLaunch = false
            }
        })
    }
}
