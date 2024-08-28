

import Foundation
import SwiftUI
import Firebase
import Combine
import FirebaseAuth
import FirebaseFirestore


enum NicknameStatus {
    case available
    case duplicate
    case empty
    case short
    case long
    case error
    case none
    
    var message: String {
        switch self {
        case .available:
            return "*닉네임을 사용할 수 있습니다."
        case .duplicate:
            return "*닉네임이 이미 사용 중입니다."
        case .empty:
            return "*닉네임을 입력해주세요"
        case .short:
            return "*한글, 영문 2자이상 입력해야해요"
        case .long:
            return "한글, 영문 10자이하로 입력해주세요"
        case .error:
            return "*오류가 발생했습니다."
        case .none:
            return ""
        }
    }
    
    var color: UIColor {
        switch self {
        case .available:
            return UIColor.green
        case .duplicate, .error:
            return UIColor.customYellow300
        case .empty:
            return UIColor.red
        case .short:
            return UIColor.red
        case .long:
            return UIColor.red
        case .none:
            return UIColor.black
        }
    }
}


class JoinViewModel: ObservableObject {
    @Published var nicknameStatus: NicknameStatus = .none
    @Published var nickName: String = ""
    @Published var departmentName: String = ""
    
    init() {}
    
    enum Action {
        case duplicateConfirmation
        case updateUser
        case updateNicknameStatus(String)
    }
    
    func send(action: Action) {
        switch action {
        case .duplicateConfirmation:
            duplicateConfirmation()
        case .updateUser:
            Task {
                await updateUser()
            }
        case .updateNicknameStatus(let nickName):
            updateNicknameStatus(nickName)
        }
    }
}

extension JoinViewModel {
    func duplicateConfirmation(/*_ nickName: String*/) -> Void {
        
        if nickName.isEmpty {
            print("닉네임 입력 필요")
            nicknameStatus = .empty
            return
        }
        
        let documentRef = Firestore.firestore().collection("User").whereField("nickname", isEqualTo: nickName)
        documentRef.getDocuments() { (qs, err) in
            if qs!.documents.isEmpty {
                print("닉네임 생성 가능")
                self.nicknameStatus = .available
            } else {
                print("닉네임 중복")
                self.nicknameStatus = .duplicate
            }
        }
    }
    
    func updateUser() async -> Void {
        guard let user = Auth.auth().currentUser?.uid else {
            return
        }
        let documentRef = Firestore.firestore().collection("User").document(user)
        
        do {
            try await documentRef.updateData([
                "nickname" : nickName,
                "department" : departmentName
            ])
            print("닉네임과 학과가 성공적으로 업데이트 되었습니다.")
        } catch {
            print("닉네임과 학과 업데이트가 실패하였습니다.")
        }
    }
    
    func updateNicknameStatus(_ nickname: String) {
        if koreaLangCheck(nickname) {
            self.nicknameStatus = .none
        } else {
            self.nicknameStatus = .error
        }
        if nickname.count > 11  {
            self.nicknameStatus = .long
        } else if (nickname.count < 2) {
            self.nicknameStatus = .short
        } else {
            self.nicknameStatus = .none
        }
    }
}



func koreaLangCheck(_ input: String) -> Bool {
    let pattern = "^[가-힣a-zA-Z\\s]*$"
    if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
        let range = NSRange(location: 0, length: input.utf16.count)
        if regex.firstMatch(in: input,options:[] , range: range) != nil {
            return true
        }
    }
    return false
}


