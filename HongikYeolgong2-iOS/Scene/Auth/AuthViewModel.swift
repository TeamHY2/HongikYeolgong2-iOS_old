

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case none
    case unSignin
    case signIn
    case signUp
}

class AuthViewModel: ObservableObject {
    
    enum Action {
        case checkAuthStatus
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case logOut
        case deleteAccount
        case createUser(nickname: String, department: String)
    }
    
    @Published var authStatus: AuthenticationState = .none
    @Published var user: User?
    @Published var errorMessage = ""
    @Published var showingErrorAlert = false
        
    private var authentication: ASAuthorization?
    private var currentNonce: String?
    private var subscriptions = Set<AnyCancellable>()
    
    // Dependency
    @Inject private var authService: AuthenticationServiceType
    @Inject private var userRepository: UserRepositoryType
    
    
    func send(action: Action) {
        switch action {
        case .checkAuthStatus:
            checkAuthStatus()
        case .appleLogin(let asAuthorizationAppleIDRequest):
            setCurrentNonce(asAuthorizationAppleIDRequest)
        case .appleLoginCompletion(let result):
            setUser(result)
        case .logOut:
            logoutUser()
        case .deleteAccount:
            deleteUser()
        case .createUser(let nickname, let department):
            signUp(nickname, department)
        }
    }
}

extension AuthViewModel {
    
    /// 로그인 여부를 확인하고 유저정보를 가져옴
    /// 앱이 처음 실행됬을떄 호출
    func checkAuthStatus() {
        guard let uid = authService.checkAuthenticationState() else {
            authStatus = .unSignin
            return
        }
        
        userRepository.fetchUser(with: uid)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in                
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    showingErrorAlert = true
                    errorMessage = "문제가 발생했습니다 다시 시도해주세요."
                    print("유저정보를 가져오는데 실패했습니다. \(error.localizedDescription)")
                    authStatus = .unSignin
                }
            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.user = user
                // 유저정보가 존재하지만 가입된 상태가 아닌경우
                if user.department != nil && user.nickname != nil {
                    self.authStatus = .signIn
                } else {
                    self.authStatus = .signUp
                }
            }
            .store(in: &subscriptions)
    }
    

    func setUser(_ result: Result<ASAuthorization, Error>) {
        if case let .success(authentication) = result {
            guard let nonce = currentNonce else {return}
            self.authentication = authentication
            self.currentNonce = nonce
            
            authService.handleSignInWithAppleCompletion(authentication, none: nonce)
                .withUnretained(self)
                .map { (owner, user) in
                    owner.user = user
                    return (owner, user)
                }
                .mapError { error in
                    return error
                }
                .flatMap { (owner, user) -> AnyPublisher<User, Error> in
                     return owner.userRepository.fetchUser(with: user.id)
                }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        signIn()
                    }
                } receiveValue: { [weak self] userInfo in
                    guard let self = self else { return }
                    self.user = userInfo
                    if userInfo.nickname != nil && userInfo.department != nil {
                        self.authStatus = .signIn
                        
                    } else {
                        self.authStatus = .signUp
                    }
                }
                .store(in: &subscriptions)
            
        } else if case let .failure(error) = result {
            print(error.localizedDescription)
        }
    }
    
    func signIn() {
        guard let user = user else { return }
        userRepository.createUser(user)
            .sink { [weak self] (completion) in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    self.authStatus = .signUp
                case .failure(_):
                    break
                }
            } receiveValue: { _ in
            }
            .store(in: &subscriptions)

    }
    
    func signUp(_ nickname: String, _ department: String) {
        guard let user = user else { return }
        let updateUser = User(id: user.id, 
                              email: user.email,
                              nickname: nickname,
                              department: department)
        
        userRepository.createUser(updateUser)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    guard let self = self else { return }
                    authStatus = .signIn
                }
            }, receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.user = user
            })
            .store(in: &subscriptions)
    }
    
    func logoutUser() {
        authService.logOut()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { [weak self] user in
                guard let self = self else { return }                
                self.authStatus = .unSignin
                self.user = nil
            }.store(in: &subscriptions)
    }
    
    func deleteUser() {
        guard let userInfo = user else { return }
        
        authService.deleteAccount()
            .flatMap { _ -> AnyPublisher<Void, Error> in
                // authService.deleteAccount()가 성공한 후 실행
                return self.userRepository.deleteUser(userInfo)
                    .catch { error -> AnyPublisher<Void, Error> in
                        // 에러 처리
                        print("userRepository를 지우는데 실패했습니다.: \(error)")
                        return Fail(error: error).eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("성공적으로 appleToken을 삭제하였습니다.")
                case .failure(let error):
                    print("appleToken을 삭제하는데 실패했습니다. \(error)")
                }
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.authStatus = .unSignin
            }
            .store(in: &subscriptions)
    }
    
    func setCurrentNonce(_ asAuthorizationAppleIDRequest: ASAuthorizationAppleIDRequest) {
        let nonce = authService.handleSignInWithAppleRequest(asAuthorizationAppleIDRequest)
        currentNonce = nonce
    }
}
