import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack{
            OnBoardingView()
            
            CustomButton2(action: {},
                          title: "",
                          image: .snsLogin,
                          maxWidth: UIScreen.UIWidth(320),
                          minHeight: UIScreen.UIHeight(50))
            .padding(.top, UIScreen.UIHeight(32))
            .padding(.bottom, UIScreen.UIHeight(20))
            .overlay(
                SignInWithAppleButton(onRequest: { request in
                    authViewModel.send(action: .appleLogin(request))
                }, onCompletion: { result in
                    
                    authViewModel.send(action: .appleLoginCompletion(result))
                })
                .blendMode(.destinationOver)
            )
        }
        .background(.bgcolor)
    }
}

#Preview {
    LoginView()
}
