import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showJoinView = false
    
    var body: some View {
        VStack{
            OnBoardingView()
            
            CustomButton(title: "",
                         style: .background(image: .snsLogin),
                         action: {})
            .padding(.top, 32)
            .padding(.bottom, 20)
            .padding(.horizontal, 28)
            .overlay(
                SignInWithAppleButton(onRequest: { request in
                    authViewModel.send(action: .appleLogin(request))
                }, onCompletion: { result in
                    authViewModel.send(action: .appleLoginCompletion(result))
                })
                .blendMode(.destinationOver)
            )
        }
        
        .onReceive(authViewModel.$authStatus, perform: { status in
            if status == .signUp {
                showJoinView = true
            }
        })
        .navigationDestination(isPresented: $showJoinView, destination: {
            JoinView()
        })
        .background(.bgcolor)
    }
}
