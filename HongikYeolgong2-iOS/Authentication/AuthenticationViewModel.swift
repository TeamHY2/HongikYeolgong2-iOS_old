

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    var userID: String?
    
    private var currentNonce: String?
//    private var contanier: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    private var authService: AuthenticationServiceType = DIContainer.shared.resolve()
    
//    init(contanier: DIContainer) {
//        self.contanier = contanier
//        guard let authService = contanier.resolve(AuthenticationServiceType.self) else {
//            fatalError("error")
//        }
//        self.authService = authService
//    }
    init() {}
    
    func send(action: Action) {
        switch action {
        case .appleLogin(let aSAuthorizationAppleIDRequest):
//            let nonce = contanier.services.authService.handleSignInWithAppleRequest(aSAuthorizationAppleIDRequest)
//            let nonce = contanier.resolve(AuthenticationServiceType.self)?.handleSignInWithAppleRequest(aSAuthorizationAppleIDRequest)
            let nonce = authService.handleSignInWithAppleRequest(aSAuthorizationAppleIDRequest)
            currentNonce = nonce
        case .appleLoginCompletion(let result):
            if case let .success(authentication) = result {
                guard let nonce = currentNonce else {return}
                
//                contanier.services.authService.handleSignInWithAppleCompletion(authentication, none: nonce)
                authService.handleSignInWithAppleCompletion(authentication, none: nonce)
                    .sink { completon in
                        if case .failure(_) = result {
                            print(result)
                        }
                    } receiveValue: { [weak self] user in
                        self?.userID = user.id
                    }.store(in: &subscriptions)
            } else if case let .failure(error) = result {
                print(error.localizedDescription)
            }
        }
    }
}
