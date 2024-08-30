

import Foundation
import SwiftUI
import Firebase
import Combine
import FirebaseAuth
import FirebaseFirestore

final class JoinViewModel: ViewModelType {
    @Published var nickname = ""
    @Published var departmentName = ""
    @Published var nicknameStatus: NicknameStatus = .none
    
    @Inject var userRepository: UserRepositoryType
    
    private var subscription = Set<AnyCancellable>()
    
    var nicknameCheckDisable: Bool {
        nicknameStatus.isError ||
        nickname.isEmpty
    }
    
    var submitButtonDisable: Bool {
        nicknameCheckDisable ||
        departmentName.isEmpty ||
        nicknameStatus != .available
    }
    
    let suggestions = [
        "건설도시공학부",
        "건설환경공학과",
        "건축학부",
        "경영학부",
        "경제학부",
        "공연예술학부",
        "금속조형디자인과",
        "기계시스템디자인공학과",
        "국어교육과",
        "국어국문학과",
        "도시공학과",
        "독어독문학과",
        "동양화과",
        "도예유리과",
        "디자인경영융합학부",
        "디자인·예술경영학부",
        "디자인학부",
        "물리교육과",
        "법학부",
        "불어불문학과",
        "사회교육과",
        "산업디자인학과",
        "산업·데이터공학과",
        "섬유미술패션디자인과",
        "수학교육과",
        "신소재화공시스템공학부",
        "영어교육과",
        "영어영문학과",
        "역사교육과",
        "예술학과",
        "응용미술학과",
        "일본어문학과",
        "전자전기공학부",
        "조소과",
        "컴퓨터공학과",
        "판화과",
        "프랑스어문학과",
        "회화과"
    ]
    
    enum NicknameStatus {
        case none // 기본상태
        case specialCharactersAndSpaces // 특수문자, 공백
        case notAllowedLength // 글자수 오류
        case available // 사용가능
        case alreadyUse // 사용중인 닉네임
        case unknown // 그외
        
        var message: String {
            switch self {
            case .none:
                "*한글, 영어, 숫자를 포함하여 2~8자를 입력해 주세요."
            case .specialCharactersAndSpaces:
                "*특수문자와 띄어쓰기를 사용할 수 없어요."
            case .notAllowedLength:
                "한글, 영어, 숫자를 포함하여 2~8자를 입력해 주세요."
            case .available:
                "*닉네임을 사용할 수 있습니다."
            case .alreadyUse:
                "이미 사용중인 닉네임 입니다."
            case .unknown:
                "올바른 형식의 닉네임이 아닙니다."
            }
        }
        
        var textColor: Color {
            switch self {
            case .none:
                    .gray400
            case .available:
                    .green
            default:
                    .yellow300
            }
        }
        
        var isError: Bool {
            switch self {
            case .none:
                false
            case .available:
                false
            default:
                true
            }
        }
    }
    
    enum Action {
        case inputNickname(String)
        case seletedDepartment(String)
        case nicknameCheck
    }
    
    func send(action: Action) {
        switch action {
        case .inputNickname(let text):
            nickname = text
            validateNickname(text)
            break
        case .seletedDepartment(let department):
            departmentName = department
            break
        case .nicknameCheck:
            checkNickname()
        }
    }
    
    /*
     한글/영어 특수문자 없이, 띄어쓰기 없이
     2 ~ 8글자
     닉네임 중복확인 필요
     */
    private func validateNickname(_ nickname: String) {
        if (!nickname.isEmpty && nickname.count < 2) || (!nickname.isEmpty && nickname.count > 8) {
            nicknameStatus = .notAllowedLength
        } else if nickname.contains(" ") {
            nicknameStatus = .specialCharactersAndSpaces
        } else if checkSpecialCharacter(nickname) {
            nicknameStatus = .specialCharactersAndSpaces
        } else if checkKoreanLang(nickname) {
            nicknameStatus = .none
        } else {
            nicknameStatus = .unknown
        }
    }
    
    /// 닉네임 중복체크
    private func checkNickname() {
        userRepository.checkUserNickname(nickname)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    nicknameStatus = .available
                case .failure(_):
                    nicknameStatus = .alreadyUse
                }
            } receiveValue: { _ in }
            .store(in: &subscription)
    }
    
    private func checkSpecialCharacter(_ input: String) -> Bool {
        let pattern: String = "[!\"#$%&'()*+,-./:;<=>?@[\\\\]^_`{|}~€£¥₩¢₹©®™§¶°•※≡∞≠≈‽✓✔✕✖←→↑↓↔↕↩↪↖↗↘↙ñ¡¿éèêëçäöüßàìòùåøæ]"
        
        if let _ = input.range(of: pattern, options: .regularExpression)  {
            return true
        } else {
            return false
        }
    }
    
    private func checkKoreanLang(_ input: String) -> Bool {
        let pattern = "^[가-힣a-zA-Z\\s]*$"
        
        if let _ = input.range(of: pattern, options: .regularExpression)  {
            return true
        } else {
            return false
        }
    }
}
