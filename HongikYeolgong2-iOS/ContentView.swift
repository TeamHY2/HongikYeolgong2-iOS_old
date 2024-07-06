//
//  ContentView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/1/24.
//

import SwiftUI

final class LoginManager: ObservableObject {
    static let shared = LoginManager()
    private init() {}
    
    @Published var signStatus: SignInStatus = .unSign
    
    enum SignInStatus {
        case sign
        case unSign
    }
    
    func login() {
        signStatus = .sign
    }
    
    func logout() {
        signStatus = .unSign
    }
}

struct ContentView: View {
    @StateObject var loginManager = LoginManager.shared
    
    var body: some View {
        Group {
            // 이곳에서 로그인 상태를 체크 현재는 임시 변수를 사용합니다      
            switch loginManager.signStatus {
            case .sign:
                HomeView()                    
            case .unSign:
                LoginView()
            }
        }
    
        
    }
}

//#Preview {
//    ContentView(coordinator: SceneCoordinator<SceneType>())
//}
