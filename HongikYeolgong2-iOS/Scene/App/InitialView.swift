

import SwiftUI

struct InitialView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    
    @State private var isFirstLaunch = true
    // 앱이 모든데이터를 받아왔을때 메인화면을 보여줌
    var body: some View {
        VStack {
            if authViewModel.authenticationState == .pending && isFirstLaunch {
                SplashView()
            }
            else if authViewModel.authenticationState == .authenticated {
                NavigationView {
                    HomeView()
                }
            }
            else {
                NavigationView {
                    LoginView()
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
