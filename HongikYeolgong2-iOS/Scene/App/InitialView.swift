

import SwiftUI

struct InitialView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    @State private var isFirstLaunch = true
    
    // 앱이 모든데이터를 받아왔을때 메인화면을 보여줌
    var body: some View {        
        Group {
            switch authViewModel.authenticationState {
            case .pending:
                LaunchScreenRepresentable()
                    .ignoresSafeArea(.all)
            case .authenticated:
                NavigationStack {
                    HomeView()
                }
            case .unauthenticated:
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
        }
    }
}
