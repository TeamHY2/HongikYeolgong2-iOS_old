

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


class NicknameViewModel: ObservableObject {
    @Published var nicknameStatus: NicknameStatus = .none
    
    func duplicateConfirmation(_ nickName: String) -> Void {
        
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
    
    func updateUser(_ nickname: String, _ department: String) async -> Void {
        guard let user = Auth.auth().currentUser?.uid else {
            return
        }
        let documentRef = Firestore.firestore().collection("User").document(user)
        
        do {
            try await documentRef.updateData([
                "nickname" : nickname,
                "department" : department
            ])
            print("닉네임과 학과가 성공적으로 업데이트 되었습니다.")
        } catch {
            print("닉네임과 학과 업데이트가 실패하였습니다.")
        }
    }
}


extension View {
    func loginTextFieldModifier(width: CGFloat, height: CGFloat, text: Binding<String>) -> some View {
        modifier(LoginTextFieldModifier(width: width, height: height, text: text))
    }
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self
            .onChange(of: text.wrappedValue) { _ in
                text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
            }
    }
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIApplication {
    func hideKeyboard() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension TextField {
    func addLeftPadding(_ width: CGFloat) -> some View {
        return self.padding(.leading, width)
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


