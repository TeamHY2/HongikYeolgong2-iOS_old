
import SwiftUI

struct JoinView: View {
    @StateObject private var joinViewModel = JoinViewModel()
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @FocusState private var textFieldFocused: Bool
    @FocusState private var pickerFocused: Bool
    
    private var nicknameBinding: Binding<String> {
        Binding<String>(get: {
            joinViewModel.nickname
        }, set: {
            if joinViewModel.nickname != $0 {
                joinViewModel.send(action: .inputNickname($0))
            }
        })
    }
    
    private var pickerBinding: Binding<String> {
        Binding<String>(get: {
            joinViewModel.departmentName
        }, set: {
            joinViewModel.send(action: .seletedDepartment($0))
        })
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 23)
            
            // 닉네임
            HStack {
                Text("닉네임")
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundStyle(.gray200)
                Spacer()
            }
            
            Spacer().frame(height: 8)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .top, spacing: 10) {
                    VStack {
                        HY2TextField(text: nicknameBinding,
                                     isFocused: _textFieldFocused,
                                     placeholder: "닉네임을 입력해주세요.",
                                     isError: joinViewModel.nicknameStatus.isError)
                        .frame(width: 213)
                    }
                    
                    Button(action: {
                        joinViewModel.send(action: .nicknameCheck)
                    }, label: {
                        Text("중복확인")
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                            .opacity(joinViewModel.nicknameStatus == .available ? 0.4 : 1)
                    })                    
                    .background(joinViewModel.nicknameStatus == .available ? .blue400 : .blue100)
                    .disabled(joinViewModel.nicknameCheckDisable)
                    .cornerRadius(8)
                }
                
                Text(joinViewModel.nicknameStatus.message)
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundStyle(joinViewModel.nicknameStatus.textColor)
            }
            
            Spacer().frame(height: 12)
            
            // 학과
            HStack {
                Text("학과")
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundStyle(.gray200)
                Spacer()
            }
            
            Spacer().frame(height: 8)
            
            Picker(text: $joinViewModel.departmentName,
                   seletedItem: pickerBinding,
                   isFocused: _pickerFocused,
                   placeholder: "학과를 입력해주세요.",
                   items: joinViewModel.suggestions
            )
            
            Spacer()
            
            HY2Button(title: "가입하기",
                      textColor: .gray100,
                      fontSize: 18,
                      style: .background(image: joinViewModel.submitButtonDisable ? .icButton : .icClearButton)) {
                
                authViewModel.send(action: .createAccount(nickname: joinViewModel.nickname,
                                                          department: joinViewModel.departmentName))
            }
                      .opacity(joinViewModel.submitButtonDisable ? 0.6 : 1)
                      .disabled(joinViewModel.submitButtonDisable)
        }
        .onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
        
        .padding(.horizontal, 28)
        .customNavigation(left: {
            Text("회원가입")
                .font(.suite(size: 18, weight: .semibold))
                .foregroundStyle(.gray100)
        })
    }
}
