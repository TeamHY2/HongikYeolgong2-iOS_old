
import SwiftUI

struct JoinView: View {
    @State private var text = ""
    @State private var text2 = ""
    @State private var isError = true
    @State private var seletedItem = ""
    @StateObject private var joinViewModel = JoinViewModel()
    
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
                        CustomTextField(text: $text,
                                        placeholder: "닉네임을 입력해주세요.",
                                        isError: isError)
                            .frame(width: 213)
                    }
                    
                    CustomButton(title: "중복확인",
                                 style: .rounded) {
                        
                    }
                }
                
                Text("*특수문자와 띄어쓰기를 사용할 수 없어요.")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundStyle(.yellow300)
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
            
            Picker(text: $text2,
                   seletedItem: $seletedItem,
                   placeholder: "학과를 입력해주세요.",
                   items: joinViewModel.suggestions
                  )
        
            Spacer()
            
            
        }
        .padding(.horizontal, 28)
        .customNavigation(left: {
            Text("회원가입")
                .font(.suite(size: 18, weight: .semibold))
                .foregroundStyle(.gray100)
        })
    }
}
