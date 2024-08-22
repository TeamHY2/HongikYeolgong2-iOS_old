import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack{
            OnBoardingView()
            
            CustomButton2(action: {
                
            }, title: "", image: .snsLogin, maxWidth: UIScreen.UIWidth(320), minHeight: UIScreen.UIHeight(50))
                .padding(.vertical, UIScreen.UIHeight(32))
                .overlay(
                    SignInWithAppleButton(onRequest: { request in
                                    authViewModel.send(action: .appleLogin(request))
                                }, onCompletion: { result in
                                    
                                    authViewModel.send(action: .appleLoginCompletion(result))
                                })
                    .blendMode(.destinationOver)
                )
        }
    }
}

#Preview {
    LoginView()
}
