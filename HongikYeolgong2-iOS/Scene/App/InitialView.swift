

import SwiftUI
import FirebaseRemoteConfig

struct InitialView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var isFirstLaunch = true
    
    var isDataLoaded: Bool {
        calendarViewModel.isSuccess &&
        homeViewModel.isSuccess
    }
    
    var isSignIn: Bool {
        authViewModel.authenticationState == .authenticated
    }
    
    var isFetch: Bool {
        authViewModel.authenticationState == .pending
    }
    
    // 앱이 모든데이터를 받아왔을때 메인화면을 보여줌
    var body: some View {
        Group {
            if (isFetch && isFirstLaunch) || (isSignIn && !isDataLoaded && isFirstLaunch) {
                SplashView()
                    .ignoresSafeArea(.all)
            } else if isSignIn && isDataLoaded {
                NavigationStack {
                    HomeView()
                }
            } else {
                NavigationStack {
                    LoginView()
                }
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)

        }.onReceive(authViewModel.$user) { user in
            guard let uid = user?.id else { return }
            calendarViewModel.send(action: .getCalendar(uid))
            homeViewModel.send(action: .getWiseSaying)
        }
    }
}
