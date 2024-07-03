//
//  LoginView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginManager = LoginManager.shared
    
    var body: some View {
        NavigationStack {
            Text("Login View 🔒")
            Button(action: {
                loginManager.login()
            }, label: {
                Text("Login test")
            })
        }
    }
}

#Preview {
    LoginView()
}
