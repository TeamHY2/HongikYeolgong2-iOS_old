//
//  LoginView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI
import AuthenticationServices
struct LoginView: View {
    @StateObject private var loginManager = LoginManager.shared
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color(.customBackground)
//                    .ignoresSafeArea(.all)
//                
//                VStack {
//                    Button(action: {
//                        loginManager.login()
//                    }, label: {
//                        Text("Login test")
//                    })
//                    .foregroundColor(.white)
//                }
//            }
//        }
        VStack{
            SignInWithAppleButton(onRequest: { request in
                authViewModel.send(action: .appleLogin(request))
            }, onCompletion: { result in
                authViewModel.send(action: .appleLoginCompletion(result))
            })
            .frame(width: UIScreen.UIWidth(320), height: UIScreen.UIHeight(90))
        }
    }
}

#Preview {
    LoginView()
}
